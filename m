Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30054C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2092224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM86ub7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHGNhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGNhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:37:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2DC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 06:37:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f1so1721994wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rox1xDaHqeLFe+gN0pc5zVRxJLvYZNTbM46yT38dB4g=;
        b=JM86ub7ONRDreDT8vPEgJxHq9AIxYi8EyOjPLQTEuF9NEkzX7A+R9zi8ZbsYA1FRO4
         btZzgtnwgDkIVElYoGn1biVgPDHL8OAEaHZ7CvGfORiS811XsvyVluJJ5goun3CGTiya
         5p2gHDoTed8RhF1TM+p2QLTSKmDMZbcH+EFx71OfpvdVykAa8A2HTS5tgNJV/Wfff4I4
         VuSmUExazZhnLONYuhgRNUSJre9LivIcHCT2t2Q58Dzi3bsumXDpwVOyLbBJ2kqTAH7g
         OjzE++n6dKZSz5T9hzSQDMVmQZ3k05TEKXKYGi3qpflg/D8s3oOj3tZWPm9pt8GJxBlH
         s4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rox1xDaHqeLFe+gN0pc5zVRxJLvYZNTbM46yT38dB4g=;
        b=jh13rlZkHTuYILceTHwBiUshVlz5JWStrJ2pOZoJGMU/X+dYemrrPyCZYKd0eSIXSt
         vb5JLygPuzMgfSaX6ham2OR2PweM+1lVjnNwoP/pAYhGdAAphZo5ldjS7f+DMrCjQIw/
         kHHK1ZQKFYH3nGfZ1MNSEcS70dric+zztExWKjhCiRhgA27jITZIjKh7r0YHRO2Pky7C
         bMUTwK8C2EnrxeOuxTrdtuMIgn7UG8biIKdtBdmuNhjDD07HqiiQUa47WNWW+cN+oKUn
         lC87MuxS2oEKBpkCsAQUQ66HSS1VY03n7iRpdJf5fKF+St9uFF8aiScxkmCEvIynPaoT
         DmxQ==
X-Gm-Message-State: AOAM533udAIFHhStxyUL492Ca7zQQoDouu+qfAmA6dZlbT8kDYm0FLSi
        4GZ4aZOGV//i7hVB00zus3o=
X-Google-Smtp-Source: ABdhPJyULErq7nubgGIzjN71SVBfJWwLKzZf4O+DlRc4zCsgkKgKr97X+yeNhVZggqq/3+Qemwuzsw==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr12346016wrn.415.1596807421085;
        Fri, 07 Aug 2020 06:37:01 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:8a1:e63e:700c:859e])
        by smtp.gmail.com with ESMTPSA id k126sm11084609wme.17.2020.08.07.06.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:37:00 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Shashank.Sharma@amd.com, daniel.vetter@ffwll.ch,
        alexander.deucher@amd.com
Subject: RFC: How to adjust the trace pid?
Date:   Fri,  7 Aug 2020 15:36:57 +0200
Message-Id: <20200807133658.1866-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

in amdgpu we got the following issue which I'm seeking advise how to cleanly handle it.

We have a bunch of trace points which are related to the VM subsystem and executed in either a work item, kthread or foreign process context.

Now tracing the pid of the context which we are executing in is not really that useful, so I'm wondering if we could just overwrite the pid recorded in the trace entry?

The following patch does exactly that for the vm_grab_id() trace point, but I'm not 100% sure if that is legal or not.

Any ideas? Comments?

Thanks,
Christian.


