Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B65BC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C79206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK2kussi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgDZPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbgDZPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 11:42:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEBBC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:42:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so7372839pgg.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U9e36U4j2X7eLfQLdeS7lmCHJFrR+c6ZsIBLujeFkfE=;
        b=IK2kussi05mfDqvtB2uLv221Q+nClXK5c64/mJOXUeE6zQg/OwRxen8KZfJMGCij7N
         dQhAileWB8ig7Apr+lX4x4EpVD5kqBwFEviXFFm5r70yaV9cH6+PjKjvhej5qWWEuJG+
         ScMuyy+EmpezZcX7YIw/5E+KlrvqFQQV1i7OA1S8FlsM7k6YIbNoMCSWZAPbkbLqE6fs
         eldqxj+8bklwT+gXJ6YmLdIg6z8sHMxNEHLFeSuSUWIsfCB+0zPfS3i9PxgExPEcWZLR
         t/U1/dd2IDDj82ku7i0OJfDp4QLd3nNFjGrUiInC04UIFBnBuGwvkXYeeOrN9GUQ0HfS
         rUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U9e36U4j2X7eLfQLdeS7lmCHJFrR+c6ZsIBLujeFkfE=;
        b=fPhheemr9AqqikI6peEOVG3b4MT24EUFfbAaTtKT6KGSZC33YbYLjf7J9HJtKvWKVK
         yz+4lQykXqVnaJE7ul6kXm+tkMY22GmuruhnQveQ+al/sr3HCiaM6nwGRgv1omaUwYqE
         izg+P5PiIAMlCKeZGytbHFBldnCJyCt4gMgpxNgPjFpgnCj92uCA0gdfP8BGus4SRuuS
         F3JxOI3FRwnxWovJH1Lc+glfVxjZt1VMxdxt9E++TmI+9AyPIaJinQCaXgg79p5aba/o
         MLCVcTSiTbqy7xlQHK47TuvN1q7q1Nn2wW2JBISg+c0IfwJubLo8s3aD86F6jgr5bGhp
         cX3g==
X-Gm-Message-State: AGi0PuYAnCvDrSt502cl53/MlSNqvXqPhnJUxtq2vZkRCIt9Ie+o4egz
        WoKTj5IRQjRzS/Ni6Wpe+ipJih7BT/paEA==
X-Google-Smtp-Source: APiQypJkJjGx0j8sPZrEDJ41uv0E4jI4jcEL1jI4MhZZvM5nLqE868BGDQtH2Z8Jkw/3+xokv+Fdow==
X-Received: by 2002:a62:5402:: with SMTP id i2mr19837716pfb.89.1587915760257;
        Sun, 26 Apr 2020 08:42:40 -0700 (PDT)
Received: from debian.debian-2 ([154.223.71.61])
        by smtp.gmail.com with ESMTPSA id b9sm10065898pfp.12.2020.04.26.08.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Apr 2020 08:42:39 -0700 (PDT)
Date:   Sun, 26 Apr 2020 23:42:35 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH -next] include/linux: delete duplicated kernel.h in nodemask.h
Message-ID: <20200426154230.xwglw6k5c3kwyco5@debian.debian-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nodemask.h, it includes bitmap.h which has included kernel.h,
so delete kernel.h from nodemask file.

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
BTW, I do not get maintainer of the get_maintainer file, so i do
not know who can accept the patch if it is right.
---
 include/linux/nodemask.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 27e7fa36f707..980b48e05d05 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -46,7 +46,7 @@
  * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
  * int next_node_in(node, mask)		Next node past 'node', or wrap to first,
  *					or MAX_NUMNODES
- * int first_unset_node(mask)		First node not set in mask, or
+ * int first_unset_node(mask)		First node not set in mask, or
  *					MAX_NUMNODES
  *
  * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
@@ -90,7 +90,6 @@
  * for such situations. See below and CPUMASK_ALLOC also.
  */

-#include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
 #include <linux/numa.h>
--
2.11.0

