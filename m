Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18834C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E251A2078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTU0yNaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDGBHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52928 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726586AbgDGBHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TH7w/JfrvK6PO93eOn/asqSkXlWjc9e7s1Mrzet5kE=;
        b=HTU0yNaMAGcK2lPvKssnI/NFrI342ixHfXQrfWXTpjpzzZeW1vtgklwxdlm6FneHSe/IUP
        tyyI1pF+0QfVhhz2jGA8Fz1CiuF99K8ASMoyf4bwY8QjekvY/N6oqPMFSe4T9O33xZvW6n
        LYYnUFJBV8HrPP3t860m5qKIWrapj3Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-nIjJUe9NP7m2a0SDWwDV8A-1; Mon, 06 Apr 2020 21:07:44 -0400
X-MC-Unique: nIjJUe9NP7m2a0SDWwDV8A-1
Received: by mail-wr1-f69.google.com with SMTP id q9so829192wrw.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5TH7w/JfrvK6PO93eOn/asqSkXlWjc9e7s1Mrzet5kE=;
        b=pVLlJeIZ+KoukYcgQWHEOK2Ly6WEyERzQTG69I4V++ep/zqIRqx18Wau2NFY0X/LGl
         a25sU+9e0UmJ4Ntna8fEmDRdaJB2v/XjJxt8u1KWvCUD+UGRpzVAm/dAo4HGRxPImiCn
         CnSgPKC+GfWPny9Qf+ZY5D5vTQCL9HVvy0cQbc3h4j1oxGT8swr1F5GFIWZ/QdJaxJ6u
         fYYCHFimdetgm8ZwUnFjc+Ow+Jxj0kaFxEzweyxcUej38NeeECTcKhresAUQkV5ruIA9
         eM6XurUfwx+VmBltMUu5KATwqKVICB/oNASQrOahQUZ009uFqkkNvmZv8SFvvOh/Up9Y
         alow==
X-Gm-Message-State: AGi0PuZ6kw5AY3n5skSsNJNRb5JcR4INFiamfJw4Be8uz3HAQVWFWA+4
        E2Ez5jG3i5CS09FtOFC5ddDVJoqJ7lvj0BejA82qDx8hPcAVm+B44jlD2tdGIojE6Gd+lger9iC
        52cZJ82LT73Q6m+HnrCSeAub1
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr1992025wmj.17.1586221662967;
        Mon, 06 Apr 2020 18:07:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKi5SDLXVoxB05X0Fa1g9oKsnmtj3oVbQGLHfVW+Qb94Vy8QZNx7bP9RNsJ+Ug6e0rfRynbiA==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr1992013wmj.17.1586221662773;
        Mon, 06 Apr 2020 18:07:42 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id o16sm28751497wrw.75.2020.04.06.18.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:42 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v7 07/19] remoteproc: pull in slab.h
Message-ID: <20200407010700.446571-8-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to virtio header changes, include slab.h directly as
this module is using it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 7f8536b73295..52b871327b55 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/remoteproc.h>
+#include <linux/slab.h>
 
 #include "remoteproc_internal.h"
 
-- 
MST

