Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C8BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A834220776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="C34ixtjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405245AbgE2CTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390865AbgE2CS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:18:58 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A2AC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:18:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n11so916985qkn.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5/ulWTNxKu3yWZsKCdG+n1pLZYJLUzJucMwpnx/Tjv0=;
        b=C34ixtjbwhTJs+0mxiEv38hlgyVg5oZ4ZUEdBIFFx0McbkQZ7C4Ar8UPmumPbeJbU8
         J93hIKwAr/NdF7UVmk2a4FtGTnVo4oF5mTJtvb3PwzSOtysVYzY9eDr2mtXOLfjSMpgC
         Ich8bcjQLU+idCXfS5jqj0Bt6uhG2FQcdAjwo1o1BOocDff47TQEwhvA+g7pxC0Fffjy
         WRV3DFr43pQFK7ONkrYVtMiIs2MSDj0XutRLhJZdT3oo1NvVrUGVnpecI4tN217ZI3dH
         LFsl7xe99Mr3I9xzSAzGKa345ob47xLdpkV2xSNu11e0SfuJS01AK7udqV0EhCw7YOuF
         91Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5/ulWTNxKu3yWZsKCdG+n1pLZYJLUzJucMwpnx/Tjv0=;
        b=IbWPPgK2QOjyQGaKugkNUASMkA7lDvUSeJljqOq6reZQ2pdm+mJZaKB9QH2FUaJTcF
         lJgQKtceRy2n0VmLq9jcLyUTxyoaxeLsjmXYdqBSEhYzAd8fap1UPGWY7oryXMFURfvj
         Kiu/L5gv4RmQ51GV42kGS3SLLiQd5u+PpQbuWna0VRuGqj9eR+ULZXF7ZT/eH0n/fpts
         AGN2ydEjRFI3VM9Bz3NrGNpxKbbsolHse4aLhhMzCVTtHGGDOOeiSI4w2jnCX0d9EC16
         BH50S3a//Wwybe6SZ80rHitXHosCRWONpFHnqGvDgjnGhgtF6/SEnqQYcxk32Zwqm6Jf
         3A8g==
X-Gm-Message-State: AOAM532wFy2lZiPGxz0W9ZRULyBmw3QspOqKFsvrBlFSZ02IMsyYGmMz
        LDnaIxXE6tpdmafMj1LgM6RI3Q==
X-Google-Smtp-Source: ABdhPJxaNAoEyQgOULt+Nf/hsDjmGyVnd7Bl1/xKq6ZTrX+c1gyKj6S7vvEfHFFjA/uUfNoODWAOLA==
X-Received: by 2002:a37:51d7:: with SMTP id f206mr5654716qkb.91.1590718736074;
        Thu, 28 May 2020 19:18:56 -0700 (PDT)
Received: from nicolas-tpx395 ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id b74sm6165768qkc.17.2020.05.28.19.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:18:55 -0700 (PDT)
Message-ID: <7be1070ee7aad1f48fc6de63523da8e1bc952dc8.camel@ndufresne.ca>
Subject: Re: [RFC] METADATA design using V4l2 Request API
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     dikshita@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, majja@codeaurora.org, jdas@codeaurora.org
Date:   Thu, 28 May 2020 22:18:54 -0400
In-Reply-To: <fb96e2c09346e7831a0af99c0fe9f94c@codeaurora.org>
References: <1588918890-673-1-git-send-email-dikshita@codeaurora.org>
         <d1179bc1-662b-615f-0f9b-67693fe8c906@xs4all.nl>
         <fb96e2c09346e7831a0af99c0fe9f94c@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 28 mai 2020 à 16:18 +0530, dikshita@codeaurora.org a écrit :
> > not allowed. So I need to know more about this.
> > Regards,
> >        Hans
> 
> we need this for use cases like HDR10+ where metadata info is part of
> the bitstream.
> 
> To handle such frame specific data, support for request api on capture 
> plane would be needed.

I have a bit of a mixed impression here. Considering how large the ioctl
interface overhead is, relying on HW parser to extract this medata woud be the
last thing I would consider.

Instead, I'm quite convince we can achieve greater and likely zero-copy
perfromance by locating this header in userspace. So everytime I see this kind
of API, were the HW is *needed* to parse a trivial bit of bistream, I ended
thinking that we simply craft this API to expose this because the HW can do it,
but no further logical thinking or higher level design seems to have been
applied.

I'm sorry for this open critic, but are we designing this because the HW
designer exposed that feature? This is so low complexity to extract in
userspace, with the bonus that we are not forced into expanding the
representation to another form immediatly, as maybe the display will be able to
handle that form directly (where converting to a C structure and then back to
some binary format to satisfy DRM property seems very sub-optimal).

Nicolas

