Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E2CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12C7206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607622;
	bh=tbigJHaGlahfqu6ShGcWa0Uyh4Y+pqsErulVyERbI1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FKeKyqRuCsdKQ4eafCrtOnZCQ1WZSjNqzzWwSbuQg6NmVvdi3fXx2p8zNt+7Io9NC
	 5WUVmeHlX6j6A7uRtBQoWUv1ERUtt45Xbhy5pYpVqIqx6bPC557HoMWxK8YoEaeobK
	 /m73aM86hBP6Y+1cKbc2NJacqnxE7MpG/Z1MUeZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbgBMP1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgBMPZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:06 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E7A24690;
        Thu, 13 Feb 2020 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607505;
        bh=tbigJHaGlahfqu6ShGcWa0Uyh4Y+pqsErulVyERbI1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWLQi21h/hLV7R85UXeGSaDEwWmh3da4ir8hE49lBQAyLHcw/oyRf+w+s1qUw+jmk
         SXI7VOwBkfUqwSQB8UJxzrZSNH+0un42lzgPcOowjbCUIiv9447L8qL7Y5y2OC+7tx
         6Sbf4WE+SfM2eNO7sNgpoylXcmBy5NP3ZWzC4nQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH 4.14 062/173] samples/bpf: Dont try to remove users homedir on clean
Date:   Thu, 13 Feb 2020 07:19:25 -0800
Message-Id: <20200213151949.478573907@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

commit b2e5e93ae8af6a34bca536cdc4b453ab1e707b8b upstream.

The 'clean' rule in the samples/bpf Makefile tries to remove backup
files (ending in ~). However, if no such files exist, it will instead try
to remove the user's home directory. While the attempt is mostly harmless,
it does lead to a somewhat scary warning like this:

rm: cannot remove '~': Is a directory

Fix this by using find instead of shell expansion to locate any actual
backup files that need to be removed.

Fixes: b62a796c109c ("samples/bpf: allow make to be run from samples/bpf/ directory")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Link: https://lore.kernel.org/bpf/157952560126.1683545.7273054725976032511.stgit@toke.dk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 samples/bpf/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -184,7 +184,7 @@ all: $(LIBBPF)
 
 clean:
 	$(MAKE) -C ../../ M=$(CURDIR) clean
-	@rm -f *~
+	@find $(CURDIR) -type f -name '*~' -delete
 
 $(LIBBPF): FORCE
 	$(MAKE) -C $(dir $@) $(notdir $@)


