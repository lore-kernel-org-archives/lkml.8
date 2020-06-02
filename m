Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85378C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6039E204EA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7FJRzwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFBIpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:45:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59269 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbgFBIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591087511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CuKIvsOKOIvk4PgTEV+w10FX9zJ+bEdYmI8o+OCWkZ8=;
        b=a7FJRzwr1k+/8/NlQzjmcQuUQobPVBYmw+SgPRa7s9zHulc8rU9lJfrEKaWJhnI2OB4BcI
        hKpWBuSF9rAq2mEuoGDcXWITrtw2q2yQwK4aCWtkPQJSgcYC9ydUZ3XkRVbWp0oR9zizSW
        nL16hBNS7Wy2+nN3nbEyYZdxjvrqtXQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-z7E6xE1XN7S55j8usNCuDQ-1; Tue, 02 Jun 2020 04:45:09 -0400
X-MC-Unique: z7E6xE1XN7S55j8usNCuDQ-1
Received: by mail-wr1-f70.google.com with SMTP id p10so1092814wrn.19
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 01:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CuKIvsOKOIvk4PgTEV+w10FX9zJ+bEdYmI8o+OCWkZ8=;
        b=SOEeTTRvIO1dKEioyYzkc21DLQdWctr+S8r5whZuyPSqlfdBKmv9gk1YOHtp2SVXJD
         GD/Kcq2kkAocCr3h4b9ouGvj+mJGB3SWwfaqaMekXufgZFo48nAfMDoeRVYmx67ivCBD
         gBITofz3TMhnU72otPSBz6a4Ey1vSSaSjp/e0HEpMae/DnsMc37OHot5L3Qbevz+woxR
         1RyNgXS3Ali80RcGn0ldRr1R3Lq/TIUiPN3qtIrA2j7j0nARQMcE706P+9TOgtLSmkci
         kKXhuCGrJAhNc60dSuMZuagV3r3Rv8uAYouxyO3wDqA2tR/FCHKco8wyNkU5q4+PVXw5
         XuKA==
X-Gm-Message-State: AOAM532tWJTxOAg7fC0Oj++/I31zKdYYjYi7YnBOiFTQq5OO+0H9h3T7
        p6GJ5im2+Mwh+R/mkOZego7VbufbDK0oxu8Pp8rXi01dG9KGReK5JWz/fdDWSWe1g+9ZY3VMlsS
        bUDbU6j/2x6sWPlSYvaQ0ZQox
X-Received: by 2002:a5d:630f:: with SMTP id i15mr24940743wru.309.1591087507796;
        Tue, 02 Jun 2020 01:45:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ22UiA8sXk0/1qLnLosKcnojExBRC52xg//ViCQ9TUbf65ilRTCSHKvDsX3BUKlBzqgKotw==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr24940731wru.309.1591087507613;
        Tue, 02 Jun 2020 01:45:07 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id u3sm2642917wrw.89.2020.06.02.01.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 01:45:07 -0700 (PDT)
Date:   Tue, 2 Jun 2020 04:45:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200602084257.134555-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So vhost needs to poke at userspace *a lot* in a quick succession.  It
is thus benefitial to enable userspace access, do our thing, then
disable. Except access_ok has already been pre-validated with all the
relevant nospec checks, so we don't need that.  Add an API to allow
userspace access after access_ok and barrier_nospec are done.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Jason, so I've been thinking using something along these lines,
then switching vhost to use unsafe_copy_to_user and friends would
solve lots of problems you observed with SMAP.

What do you think? Do we need any other APIs to make it practical?

 arch/x86/include/asm/uaccess.h | 1 +
 include/linux/uaccess.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index d8f283b9a569..fa5afb3a54fe 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -483,6 +483,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 	return 1;
 }
 #define user_access_begin(a,b)	user_access_begin(a,b)
+#define user_access_begin_after_access_ok()	__uaccess_begin()
 #define user_access_end()	__uaccess_end()
 
 #define user_access_save()	smap_save()
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad..4c0a959ad639 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -370,6 +370,7 @@ extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
 
 #ifndef user_access_begin
 #define user_access_begin(ptr,len) access_ok(ptr, len)
+#define user_access_begin_after_access_ok() do { } while (0)
 #define user_access_end() do { } while (0)
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
 #define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user(x,p),e)
-- 
MST

