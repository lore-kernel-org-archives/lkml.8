Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58FEC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50BB246B9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="M893la1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgB1QfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:35:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:48917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgB1QfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582907688;
        bh=YcG6r7F3VVt7DQsFNhV4JbQ/Bh6aKNh0DkfRxFndYAA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M893la1WZgDW7/xWaBckbU4Odje3StaE2YcrGjt7TLxyK3pbX/Ea23pa9tN/cHEH7
         joHd8VOqO6RSYD0a0SS6Ty3j2XCMW2ucMF+AzxWLxQmzVPStkZStnqrxLMH4lEZRAD
         CzydVU3Wqs7ndlgvC4LH1dlsW2OpHQHQinHzZuGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.53.40.15] ([185.53.40.15]) by web-mail.gmx.net
 (3c-app-gmx-bap21.server.lan [172.19.172.91]) (via HTTP); Fri, 28 Feb 2020
 17:34:47 +0100
MIME-Version: 1.0
Message-ID: <trinity-1aeda07b-567b-4a31-a709-36199975894b-1582907687950@3c-app-gmx-bap21>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Bibby Hsieh" <bibby.hsieh@mediatek.com>
Cc:     "David Airlie" <airlied@linux.ie>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        "Bibby Hsieh" <bibby.hsieh@mediatek.com>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, "CK Hu" <ck.hu@mediatek.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [BUG] [PATCH v5 3/7] drm/mediatek: update cursors by using async
 atomic update
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Feb 2020 17:34:47 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20191210050526.4437-4-bibby.hsieh@mediatek.com>
References: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
 <20191210050526.4437-4-bibby.hsieh@mediatek.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:2wHSXETBujv7ubTGIwZ5VrMFtJmoX/njL13MkH8s5eovSX+Y+sTe0+BByPkiM5mY2rzQm
 gKpnl5HTR1TX8ZwimXy747VbCYUysGQw+GdtehRIGT5il+WUm2aG81V2Bu0Dpft2U3SY51brmqYE
 H0JgZOtLaL0+tXa8kZMGxWwyoVLkjFO5i3HFnIccGF/d2ihL7iTlHuSy3H9axD1B76whc67PrgRz
 VBlEsXrblvHd0UmCQ6WWGJeRXN83aG2f7ScyhV9hAm1fz/xBSUnehkXcTmbnfvD6ndAjICp0ek9M
 Rc=
X-UI-Out-Filterresults: notjunk:1;V03:K0:K7AD3qghSCg=:KDuvUtyqh0IxQhZ8dH9kvu
 UkMiaACx+8TarnVTvKLAKYfLysNr+9tfMvPZLRxVtUh1T0O1DBm4Rko4sdLxfCcUGMflBCrDF
 ciX4YIyA6kuUTwucfzx22ITRFECEbD2yoh1WgJbxUXd9NJYwXopioXyMMrwaM6xnYz/nLIr7o
 mUGZMog7Dou+NeR5Em4TB8BEgRtUTLT6+nfdjLNz4ShGizgdYRFKt+/vHZk/V1IW+aFci1vsg
 LHvupXQWPTqlYNA3JS0Km5lF3zWjBdUJIGrdIGympZEuHb5mAtd4vGX9XsCeZH3p1WjQ/MpQY
 4acYwTHnCUAyGf7pGu2tzR8WsBvTvBOIW4Q8I03JkR+4har3qSWjIcdqgk2ff+6RSbEXVjquZ
 C7mZBt3pEMeZjKM+Z1HkvLnv2XrRM8CB/s3gUG3quARYuumwpA7BH7F7fOTjduxgqWlhv3YVO
 mhEDvNNyn9mge3Vz9N5MalwRkGJ5FJFlPEG9tEBlGoHxehlLMAMYcXVl4oE5ffpiFOpSG15y4
 rm2LvOfG+tHze6Pl5a18bTr459tAbHXJYVUGnvmhov147zK1eBq3bFk9JHKV0fMl5up+E2is1
 +YOSmDnrCG2i9TqD76kwDIFdZnprjEY1f1rR8oEq2QgrAsYW0byi74bJRq34xclYgmkooSZsk
 eGfDPVeomp5G0jsWbOdU4oBMCEo7ol8LkDiWjXMdSbjZUOrU62FolI9j7z62bk/OQrp0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as talked to Bibby directly, this Patch seems to create a bug with touchscreens. Cursor is displayed on old position if changing its position. e.g. Cursor was on X1,Y1 and i touch to new position X2,Y2 the "click" is recognized on right position (i try to ), but cursor is displayed on X1,Y1

have made a small video and uploaded to my gdrive [1]...

here i use lightdm login manager and selecting the username/password-fields alternately. Focus follows, but cursor is always displayed on prior position

tried to revert this commit [2], but there are many depencies failing the revert, have not yet got all depending commits reverted

regards Frank

[1] https://drive.google.com/open?id=1Qy0tYnbO9zNGdjCWY18O-dMYbFuPrq_i
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=920fffcc891276a855cb3ce1e7361d2e9cb72581
