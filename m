Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EDAC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58406206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JoitJ2UP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgG1PFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:05:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53395 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbgG1PFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:05:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200728150506euoutp027fff04737d43944d232e78095bb1ebf4~l8uSht_ro0522505225euoutp025
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:05:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200728150506euoutp027fff04737d43944d232e78095bb1ebf4~l8uSht_ro0522505225euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595948706;
        bh=+jPJ4jLPZRlRRWDMyw7UrrbUfNlzvkLzijZOathISTs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JoitJ2UPs2jBibLt7w/WwDp6Tbm0ijMBZ6o3rAS12jgldGHIsCQQepamP7CnSSiVj
         Lw+Sh9Zl1Cr4BfkJrs75jig0VQLV+nBIVmd0TPJPAWpXuDCLMMGkH80nAf9KehJhaN
         /QH8QNCJpQeHFsr/eEqQ5d51nxRrh/Nrr2xT0iMk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200728150506eucas1p214e6b64b60b624fef376c8cf9320d31e~l8uSB1xV62602526025eucas1p2U;
        Tue, 28 Jul 2020 15:05:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B9.EB.06318.2AE302F5; Tue, 28
        Jul 2020 16:05:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200728150505eucas1p28f7907c32b5cdb2259520197e602d9d4~l8uRteI7a2196021960eucas1p2h;
        Tue, 28 Jul 2020 15:05:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200728150505eusmtrp1a911fed0ff536f13ff87e5a554885c6c~l8uRsya7v2594525945eusmtrp1S;
        Tue, 28 Jul 2020 15:05:05 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-ec-5f203ea2e55d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E8.53.06314.1AE302F5; Tue, 28
        Jul 2020 16:05:05 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200728150504eusmtip17a30673d18eef82b371bf0f3e7d88d37~l8uQC7qFf3170531705eusmtip1h;
        Tue, 28 Jul 2020 15:05:03 +0000 (GMT)
Subject: Re: [PATCH v9 0/4] driver core: add probe error check helper
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <e55a23bf-59bb-43c6-f7d7-467c282b8648@samsung.com>
Date:   Tue, 28 Jul 2020 17:05:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713144324.23654-1-a.hajda@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XbOzo7W5HNZezErG/SHRa2cxRFD7EYn6IagUZE686ClM9u0
        zAqHN9TKrLByqYkpmVnm3Fpaac3IzEy7iUIxYoVZ2govqWnk8Szyv9/3Ps97eeCjCdl3sSd9
        ID6R08ar4xSUK3n36VjH8rJA7/CVn4dppi+/GTG1l2vETMHHTxTzdthBMenXaijm3a8+gmnt
        f0cyOefKJYzR3iVm3jQUUYy14CFibj35IGGseXuZ4qECIsiNfdP1imAd3ZkStt7wQcJeyS4U
        s8aqHIp9lv9axDYVV0tY26kWEVtXnsrmmaoQ++jMBZIdNC7cOXuP69ooLu7AEU6rDIxwjbn9
        e1KUMOCePN5ipfTILs1FLjRgPxhsyxLlIldahisRpF3MEguPIQTV3bVOZRBB50iX5F/LkHmQ
        4FmGryOw9LoJJgeCiZIBES/MwZugymImefbAKjjbbpDwJgKbSDhnKRDzAoV9YLKuh+JZigNB
        3587zSReAhef1CGe5+IwqOmziASPO7QWfpoaStMu2B+u5u3iywReBJaBIkJgOaQN3ZiOALiQ
        hka7jRCu3ghF/U9FAs+Bry0mZxovaLtwmhQ4FWyVGYTQnI3AfKfe2RwA71+OU/xiYuromgal
        UF4HIyW9BF8G7AbdA+7CDW5w/u4lZ1kK2Vkywb0YbO1m50A5VHQOU/lIYZgRzDAjjWFGGsP/
        vaWIrEJyLkmnieZ0qnju6AqdWqNLio9esf+QxoimfmHbn5bhe6hxItKKMI0Us6WX53qHy8Tq
        I7pjGisCmlB4SNe3t4XJpFHqYymc9lC4NimO01nRfJpUyKWqsr59MhytTuRiOS6B0/5TRbSL
        px4RnsXBQT0deduWncjw2asaDTXZvX3O7Av1xiURmuaS3ck/M/UvbPN3dCx4/sX3ODps7t5S
        WNqQru+sPuj32F/5IOekvf5+fcj2EDbFPkZu2BKlQXKTP3daqQzb+i14W7YjQRGwefXNg7GR
        PY9l80ZDKtZI9T9MsxzhyNjk26vyUpC6GPWqpYRWp/4LOK3SioEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4Xd2FdgrxBsd7jSxeTjjMaLFxxnpW
        i6kPn7BZXPn6ns2iefF6Nour318yW5x8c5XFonPiEnaLTY+vsVpc3jWHzeLQ1L2MFmuP3GW3
        ONQXbTH3y1RmBz6Py9cuMnu8v9HK7rFz1l12j9kdM1k9Nq3qZPM4MeESk8f+uWvYPe53H2fy
        2Lyk3qNvyypGjwO9k1k8Pm+SC+CJ0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7Uy
        MlXSt7NJSc3JLEst0rdL0MtY9/svU8FbwYpfxw+xNTA+5u1i5OSQEDCR+LL1M3MXIxeHkMBS
        RomVb7pYIBLiErvnv2WGsIUl/lzrYoMoessosWD+cXaQhLCAq8Sq7VvBGkQEjCX6z85iByli
        FtjFIrF60kNWiI4eRokDbw4yglSxCWhK/N18kw3E5hWwk2h40wVmswioSkw7shmsRlQgTmL5
        lvnsEDWCEidnPgHawMHBKWApMb8vHCTMLGAmMW/zQ2YIW15i+9s5ULa4RNOXlawTGIVmIeme
        haRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM/23Hfm7ewXhpY/AhRgEO
        RiUe3g/iCvFCrIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsRoCvTbRGYp0eR8
        YGrKK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAyGHMY6BoUNj+
        4+xEozXpdfn7ilfn/7mR/7Q++PC1d6EloY9+CyeJ6t6LKHrFfXvvCYdFedVb2m69cxPwDn08
        4Vzg0vXrFSJNvlpu+1FROkdFSGCyurxiyu/JFzx28HxxUDpy4aLQLO9YFqXcw8rhHgzJvLf+
        m3QzJnBL+Av3vTjQ9DmZY46cEktxRqKhFnNRcSIA9crzRBUDAAA=
X-CMS-MailID: 20200728150505eucas1p28f7907c32b5cdb2259520197e602d9d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200713144331eucas1p25911c4ffa9315f632d8f6dd833588981
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200713144331eucas1p25911c4ffa9315f632d8f6dd833588981
References: <CGME20200713144331eucas1p25911c4ffa9315f632d8f6dd833588981@eucas1p2.samsung.com>
        <20200713144324.23654-1-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Apparently the patchset has no more comments.

Could you take the patches to your tree? At least 1st and 2nd.


Regards

Andrzej


On 13.07.2020 16:43, Andrzej Hajda wrote:
> Hi All,
>
> Thanks for comments.
>
> Changes since v8:
> - fixed typo in function name,
> - removed cocci script (added by mistake)
>
> Changes since v7:
> - improved commit message
> - added R-Bs
>
> Changes since v6:
> - removed leftovers from old naming scheme in commit descritions,
> - added R-Bs.
>
> Changes since v5:
> - removed patch adding macro, dev_err_probe(dev, PTR_ERR(ptr), ...) should be used instead,
> - added dev_dbg logging in case of -EPROBE_DEFER,
> - renamed functions and vars according to comments,
> - extended docs,
> - cosmetics.
>
> Original message (with small adjustments):
>
> Recently I took some time to re-check error handling in drivers probe code,
> and I have noticed that number of incorrect resource acquisition error handling
> increased and there are no other propositions which can cure the situation.
>
> So I have decided to resend my old proposition of probe_err helper which should
> simplify resource acquisition error handling, it also extend it with adding defer
> probe reason to devices_deferred debugfs property, which should improve debugging
> experience for developers/testers.
>
> I have also added two patches showing usage and benefits of the helper.
>
> My dirty/ad-hoc cocci scripts shows that this helper can be used in at least 2700 places
> saving about 3500 lines of code.
>
> Regards
> Andrzej
>
>
> Andrzej Hajda (4):
>    driver core: add device probe log helper
>    driver core: add deferring probe reason to devices_deferred property
>    drm/bridge/sii8620: fix resource acquisition error handling
>    drm/bridge: lvds-codec: simplify error handling
>
>   drivers/base/base.h                  |  3 ++
>   drivers/base/core.c                  | 46 ++++++++++++++++++++++++++++
>   drivers/base/dd.c                    | 23 +++++++++++++-
>   drivers/gpu/drm/bridge/lvds-codec.c  | 10 ++----
>   drivers/gpu/drm/bridge/sil-sii8620.c | 21 ++++++-------
>   include/linux/device.h               |  3 ++
>   6 files changed, 86 insertions(+), 20 deletions(-)
>
