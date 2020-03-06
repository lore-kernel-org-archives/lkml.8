Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF423C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B554206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cLRtfxoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCFVJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:09:04 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33872 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCFVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:09:03 -0500
Received: by mail-wr1-f43.google.com with SMTP id z15so3973269wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 13:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=26Sq85vpjRSteJm5jvInxBanL+YHiCYPey00VEQD8F8=;
        b=cLRtfxoZGwd49oQ/cSgBBxapBQC8Ed31LFCvLKWWm4zURoL5NCgL9T6gXU3O/YLX9b
         bu2ClVKTMWAagnJmjZ8UVHBajmkrZ6AOI/4D6UohQnUw8oAacXTpoKIADxsE993noHXC
         T7RZFsQ8UvKvgFY4lOe9GS/lvqoZMbcrzc3mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=26Sq85vpjRSteJm5jvInxBanL+YHiCYPey00VEQD8F8=;
        b=UOBRI/NvXJmyChTTDVbaLjO4cMnaN7phbx0fJrd3qcWfC6+MCU3TTPZiAYGzjpU6x2
         mbeswvFMR8W/Us1K+AfVZcLpYWTvut2CcMCQ2sgzGDB/oNFvQBEWy1rt1kRRaQ4MYqrL
         WgFaHPc+HeEKpOrfNQ4D6xYJOSsqBb4YANkE0CjAv8K/qJRZiCdcyWwvNR99O+jlwknZ
         t6mw2cwY/6/Ia85T/7Tej/QP+uN1T/jQoWBhXEBdFSrmQiu37eYh9xdL733uvkh/S6Q8
         VTEg3kDwNSzf+3C+/YZGYrYpCaElqTnad46+V+anZicj0xbzZJhH/H01pPeGkMMlCPTd
         ERsQ==
X-Gm-Message-State: ANhLgQ0n14kGWvrQ+LwOQ4oTQvGi0lbHcRaVe8jHgrb6MpQgVw9K1HLD
        shr40N6N0DR1Cnz3QFmcbpmVmA==
X-Google-Smtp-Source: ADFU+vsACGhb6mJONDejOXhmARY5fMWATKiKJGT1hnE1V39dTnC/f5B9Nuv19LJ5/6zOD+TOq1plsw==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr5661870wrn.230.1583528941542;
        Fri, 06 Mar 2020 13:09:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o16sm35619867wrj.5.2020.03.06.13.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 13:09:00 -0800 (PST)
Date:   Fri, 6 Mar 2020 22:08:54 +0100
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PULL] drm-fixes
Message-ID: <20200306210854.GA638432@phenom.ffwll.local>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the pull for the lone vgacon fix that we discussed. I added a short
explanation to the commit message where the overflow safety check is.

drm-fixes-2020-03-06-1:
one vgacon input check for stable

Cheers, Daniel

The following changes since commit 2ac4853e295bba53209917e14af701c45c99ce04:

  Merge tag 'amd-drm-fixes-5.6-2020-03-05' of git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-03-06 11:06:33 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-06-1

for you to fetch changes up to 513dc792d6060d5ef572e43852683097a8420f56:

  vgacon: Fix a UAF in vgacon_invert_region (2020-03-06 21:06:34 +0100)

----------------------------------------------------------------
one vgacon input check for stable

----------------------------------------------------------------
Zhang Xiaoxu (1):
      vgacon: Fix a UAF in vgacon_invert_region

 drivers/video/console/vgacon.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
