Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD9FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889C120661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338712;
	bh=StvTK6+608Rc+mF19RXGksdZ5Delha5xSdGRrD8cACo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hi6XALYG+A7D9YgMgMEHfXhaOk4YQKSmcAgCpHVAeyQxobo/0leP4RffoU5XrIbWt
	 9QyAuzLQjwNWdLgAFiWCczp3I8eJb5nA8+Storg3FZX2E1JpgK4YTnWlrJbESDhOzt
	 yKvkvgYPHDBZ6kpwoKh6RSczAXPoYOzFSGaYhRCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgBJMpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgBJMk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:56 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE6BF20733;
        Mon, 10 Feb 2020 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338456;
        bh=StvTK6+608Rc+mF19RXGksdZ5Delha5xSdGRrD8cACo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjjvaEEG+BP6bpaze8T9kfEw7gcf0s+AdV4v/alsI1xOmMvtsvDWd/9Z0Eajt0bVZ
         nTNWb+J9bbxQ9n44rAMX4TGl73MBahVf3A33n7hlAaewCM3ngfVw9fcy2TiHkM2Hn0
         L9KIi+yFj7PG63Fas4e5ut+xgzuYegtjPC9iYGUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 166/367] tc-testing: fix eBPF tests failure on linux fresh clones
Date:   Mon, 10 Feb 2020 04:31:19 -0800
Message-Id: <20200210122440.202590269@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

commit 7145fcfffef1fad4266aaf5ca96727696916edb7 upstream.

when the following command is done on a fresh clone of the kernel tree,

 [root@f31 tc-testing]# ./tdc.py -c bpf

test cases that need to build the eBPF sample program fail systematically,
because 'buildebpfPlugin' is unable to install the kernel headers (i.e, the
'khdr' target fails). Pass the correct environment to 'make', in place of
ENVIR, to allow running these tests.

Fixes: 4c2d39bd40c1 ("tc-testing: use a plugin to build eBPF program")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py
@@ -54,7 +54,7 @@ class SubPlugin(TdcPlugin):
             shell=True,
             stdout=subprocess.PIPE,
             stderr=subprocess.PIPE,
-            env=ENVIR)
+            env=os.environ.copy())
         (rawout, serr) = proc.communicate()
 
         if proc.returncode != 0 and len(serr) > 0:


