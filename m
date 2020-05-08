Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E3EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEB1218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942618;
	bh=Afv2FaG5DQaHqoUBgBp0RuCQ3U8KX62WJDiJFCsqfJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hrk6Mu17d6iFMcGIFQosx5ST/f79/3jEA1teIQENSfQ5fCgU3TUg6JU+CDQaEt4za
	 ne3fq2vNGZyRvsazGBnC/eALMH9m7fHgaUoeQ9PwJS8e+Xw0+rEbSwtOZA4+0SBD6G
	 NroqBLA84y+/xlvuVFjHZHg72xTZ913hxKK4nMvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgEHM44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730420AbgEHM4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:56:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD9792054F;
        Fri,  8 May 2020 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942572;
        bh=Afv2FaG5DQaHqoUBgBp0RuCQ3U8KX62WJDiJFCsqfJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOwSX04aU0Efwu06TnzBvAt0xyDXYo1z5uGX3fCVpo+JBWBR0uZaD0XQz7aWrFUVt
         mfSDJYW/b0758+PKpBeNp2z+CvTTq5WyQD905QIy45a4DdWhgNRxkguTOOzGx/UwXV
         XharQXwr1vItIRQTCoL5isy5f6DzwpsO+6gbn32g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Dmitry Yakunin <zeil@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 48/49] cgroup, netclassid: remove double cond_resched
Date:   Fri,  8 May 2020 14:36:05 +0200
Message-Id: <20200508123049.452001905@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

commit 526f3d96b8f83b1b13d73bd0b5c79cc2c487ec8e upstream.

Commit 018d26fcd12a ("cgroup, netclassid: periodically release file_lock
on classid") added a second cond_resched to write_classid indirectly by
update_classid_task. Remove the one in write_classid.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Dmitry Yakunin <zeil@yandex-team.ru>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/netclassid_cgroup.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -127,10 +127,8 @@ static int write_classid(struct cgroup_s
 	cs->classid = (u32)value;
 
 	css_task_iter_start(css, 0, &it);
-	while ((p = css_task_iter_next(&it))) {
+	while ((p = css_task_iter_next(&it)))
 		update_classid_task(p, cs->classid);
-		cond_resched();
-	}
 	css_task_iter_end(&it);
 
 	return 0;


