Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDDAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8032146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258407;
	bh=2o5tI0QQbtYWwGNX7U5m4+4KDXD+MHoW19fv1Xr8ZPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iHjgC+vJs2/4Vg8boQYtUzpeGAaC5b3w/cTV5ZSYrksRwGimQPCFpIooNRbZMn2nw
	 Uqk7vpgDze0SekTcoElcOFysDXjs+J67mXpgjA1NZKt4ekonXCzdv4YqXfnvtuyC0x
	 +djSeCTPt6/HBbXQAtBSda4m63lckRDwjhWcDmDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbgCCR6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:58:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733199AbgCCR6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:58:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A70D20656;
        Tue,  3 Mar 2020 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258281;
        bh=2o5tI0QQbtYWwGNX7U5m4+4KDXD+MHoW19fv1Xr8ZPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xwwT1vuJq1zOUxfbZ2gAPc7SJbOyiY7KKhkixfyiVoZ4SCDITgPJXNAxI+0PERfJ3
         QfjMmO8CrJxJWmJev9+ste5+k1pxEythR9jOH8+u56HrAhkhPzHesWK+mLemAMfjT/
         0dgAD3hLuK8/sOSuA5KY4JxezUYbFCc8gKpXbqyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 142/152] netfilter: nf_flowtable: fix documentation
Date:   Tue,  3 Mar 2020 18:44:00 +0100
Message-Id: <20200303174318.927654999@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

commit 78e06cf430934fc3768c342cbebdd1013dcd6fa7 upstream.

In the flowtable documentation there is a missing semicolon, the command
as is would give this error:

    nftables.conf:5:27-33: Error: syntax error, unexpected devices, expecting newline or semicolon
                    hook ingress priority 0 devices = { br0, pppoe-data };
                                            ^^^^^^^
    nftables.conf:4:12-13: Error: invalid hook (null)
            flowtable ft {
                      ^^

Fixes: 19b351f16fd9 ("netfilter: add flowtable documentation")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/networking/nf_flowtable.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/networking/nf_flowtable.txt
+++ b/Documentation/networking/nf_flowtable.txt
@@ -76,7 +76,7 @@ flowtable and add one rule to your forwa
 
         table inet x {
 		flowtable f {
-			hook ingress priority 0 devices = { eth0, eth1 };
+			hook ingress priority 0; devices = { eth0, eth1 };
 		}
                 chain y {
                         type filter hook forward priority 0; policy accept;


