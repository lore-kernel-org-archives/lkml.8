Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5388FC2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C295206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586810570;
	bh=nA2rxmtDBBmgWKbbBmRcjwmmhyHuBE4mnSr6pOW6nHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QAb17FonaIORMcud9JkpOg8Nabgdc1NTLVWiJUCbKS727Zlb6Yggw40ISDhNOl74E
	 KO80QJsX0t4B+Lh2UT2XkRVDLhk/lgHcGm+7NYh8W7x+790e0Br1MNYBrd9IZwQhsw
	 TWBk7QywtYDhoyyf1iWAx9Trlcj5izeRBDouvD/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbgDMUmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388484AbgDMUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:42:46 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E392C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:42:46 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id w26so5100704qvd.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1mj+zoPGRVqWrxi/vvLzrvA5AEZNWCyvl7tzM/qPtFc=;
        b=LnaJmW1uo4IPSACFJhtZVeJJPJqKj/pM31yQfUa02ZWgGNFDHIiEM2viym6/A4Jwip
         H/SvYmxHQi7Z9abTF87JeF0/6e2mBCiXgPdzGlMOGf8h7briaICgskM7jliuRQ8A62ek
         F2JsJozQ9zM2I25fdUTTgm/ODu7EFug955vlNzj4qco1jLzNs3uLWWGp1R3Hii6Qncmc
         JAk/A5lVYsfI91a+fJc0JECEocip8W6LuGOibiUay5oFDSNhb+KzC0O6e32Uip/MxbET
         0y6tz9QOvyz0V1i914snrtmCmeF+/7VTjiY78yznKfZLzCgk0Rwzy2RP13YdOLjkIIWV
         ao/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1mj+zoPGRVqWrxi/vvLzrvA5AEZNWCyvl7tzM/qPtFc=;
        b=C3TrsazqwMQuzL0QMhYAht/VrlPAGQOzw3AYWyMlBKdD9tDGK6vLRevFl+tyoBCBBM
         VrAsSwXbD2wqJyaTEV2OTTUjLkSkcjuwvSFrjEOjRUULpPI0wQ9GY9JIR3XkSCs33N0W
         3XtDJ6kGi8Bo5vgI61+nd9hhI7LE1DB0zx2LKx1e/zPQD3wkmfK4MXTBiaTQ4nj5c3KH
         tOhDvywuaf6KAY8SHx65ZVqKr8bqf+xzR/M70czite/vPrfHHx+0UnGyRfGJLjt4XSbr
         YuBI3v5PPVxJjofxkReghxPWDzpBNlFoEwrf6bqrdUuvF+Tux+xGCTdOCpdg4eCG9wGD
         47gw==
X-Gm-Message-State: AGi0Pubwz31Szyc0rhnlpbYbZQdfEE23tkYRQ6XIKhxmSn2BNVirU4UD
        sy/kIWzzyrPux9k4G+gUuXQ=
X-Google-Smtp-Source: APiQypIyKqzTfr7aXMKcUHjgucIatzgk06mFeQ4P6AU7xMuMjtSMR7m3JauQN/p39x+cCVx/GxM3fg==
X-Received: by 2002:a0c:df02:: with SMTP id g2mr5818617qvl.115.1586810565321;
        Mon, 13 Apr 2020 13:42:45 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id 63sm3743142qkl.64.2020.04.13.13.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 13:42:44 -0700 (PDT)
Date:   Mon, 13 Apr 2020 16:42:43 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] drm/vblank: Add vblank works
Message-ID: <20200413204243.GL60335@mtj.duckdns.org>
References: <20200318004159.235623-1-lyude@redhat.com>
 <20200318004159.235623-2-lyude@redhat.com>
 <20200318134657.GV2363188@phenom.ffwll.local>
 <e4fb0c39ec024d60587e5e1e70b171b99eb537f4.camel@redhat.com>
 <faf63d8a9ed23c16af69762f59d0dca6b2bf085f.camel@redhat.com>
 <96cb912809f99d04cd5cdd46c77b66b8c1163380.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96cb912809f99d04cd5cdd46c77b66b8c1163380.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Apr 13, 2020 at 04:18:57PM -0400, Lyude Paul wrote:
> Hi Tejun! Sorry to bother you, but have you had a chance to look at any of
> this yet? Would like to continue moving this forward

Sorry, wasn't following this thread. Have you looked at kthread_worker?

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kthread.h#n71

And, thanks a lot for the vblank explanation. I really enjoyed readin it. :)

-- 
tejun
