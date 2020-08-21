Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187D220732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HRr0mc96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHUHUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:20:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55040 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgHUHSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:55 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200821071850epoutp020c899481d3ffce20fdb4dd7d69c01fbd~tN2CIgp6d1461414614epoutp026
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:18:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200821071850epoutp020c899481d3ffce20fdb4dd7d69c01fbd~tN2CIgp6d1461414614epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597994330;
        bh=LxG/BRJPUPXKdOEKof4PSscxPda3iDz24nJLGRl/2gI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HRr0mc96xKVY+hEJpiK181aOrJ1S3goYNBZ7UcZ6VAeF1kUREmOoINROgox6F8Ktd
         SU6qemduImZ+94kYUsR3o47XvmdD2cMr0p2UcOR68UuVIyhceBGSpSBEHcRf26RI4W
         MzHApoR2IFoy9buahDsRwFokSFE8mxSkV9wcI/jA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200821071849epcas1p10d516b258c29ee7773e7a62eb2d442a5~tN2BmkAlX0834508345epcas1p1x;
        Fri, 21 Aug 2020 07:18:49 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BXtD75RvFzMqYm0; Fri, 21 Aug
        2020 07:18:47 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.FF.18978.7557F3F5; Fri, 21 Aug 2020 16:18:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200821071847epcas1p27d0f061d982ab0befd58889c8a1c043e~tN1-EYHdL1319413194epcas1p2X;
        Fri, 21 Aug 2020 07:18:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200821071847epsmtrp1b8a7b6d8a61fb6fe412093ffb5ef348e~tN1-DL0nG2746327463epsmtrp1S;
        Fri, 21 Aug 2020 07:18:47 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-1d-5f3f75570b13
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.82.08382.6557F3F5; Fri, 21 Aug 2020 16:18:47 +0900 (KST)
Received: from [10.113.111.64] (unknown [10.113.111.64]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200821071846epsmtip184a295abb5d3d1935a2b4ea841edd60e~tN1_noi0a1986919869epsmtip1Y;
        Fri, 21 Aug 2020 07:18:46 +0000 (GMT)
Subject: Re: [PATCH v4 00/78] drm/vc4: Support BCM2711 Display Pipeline
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     devicetree@vger.kernel.org, Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>
From:   Hoegeun Kwon <hoegeun.kwon@samsung.com>
Message-ID: <1a39aedf-b708-e490-6acb-9a07e1b73300@samsung.com>
Date:   Fri, 21 Aug 2020 16:18:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO3vv3t1lXLouPs5sUXBnaNQGZFnWDgisQ6jXKZ1tnDIbaLvt
        XoGA3Z29ixlNuuVAsYI8CoRFwwJBICieiUUwKDhKCCauxiNGAgILlmhIHqO0y8WJ/z7n/L6/
        3/f3Ow8xJnMScnG8wcKaDUwiRXjgTVe2BvgfSlZrAzv+2oKqMztwNHWuBEfFV28KUd+ck0Bt
        H98GyFluI1BzXzWO6n53CNHfGb8J0e3LZwmUM/CdCBXMPwbo1o3dqMleTqCa/j8JlNpyVYQe
        O2pxNJI3DHbJ6E+cnQTtvJcqou3D3QQ9eLOHoJvtQyK6rjKdoIdPXRPQ9aUn6NSORZw+3VAJ
        6PquD+l/6p7TrHsrISyOZfSs2Yc16Iz6eENsOPXKQe3LWtWOQIW/IgS9RPkYmCQ2nIp6VeO/
        Jz7RNR3lc5RJTHZtaRiOo7ZHhJmNyRbWJ87IWcIp1qRPNIWYAjgmiUs2xAbojEmhisDAIJVL
        +E5CXG7dkMA08+axP6quiKygKtIGJGJIBsPZiQrcBjzEMvISgMtFNoE7ICNnAVycj+YD/wL4
        xaOfiScZ6ddrRHygBUDHfYeAX0wBODfcJ3SrvMi9sLTkJO7mDeT78NP0VszNGFmPw5KJ/W4m
        SH84l3F3xU5KRsCuqnbgZpz0g9OD3SI3byQPw+axSRGvWQ+vF46u1JSQLCxr/UbA13wenmws
        Wq2/GfaPFq80BMksCUy1F2J821GwtqZXwLMXfHCtQcSzHE5mpa0yB/sKH+B8shXArJyi1YAS
        tl743JUsdjlshd9e3s5v+8LmpXOAN/aE03MZQrcEklL4WZqMl7wAx61tQp6fhTcyy1dboGFF
        cRbIBr72NaPZ14xjXzOO/X/j8wCvBJtYE5cUy3IKk2LtbdeBlZe/TXUJ5EzNBLQDgRi0AyjG
        qA3SzJadWplUz3yQwpqNWnNyIsu1A5XrsHMw+Uad0fV1DBatQhWkVCpRsGKHSqGgNkvv9/to
        ZWQsY2ETWNbEmp/kCcQSuVVw0SbYtRS9FBXi/f17MZj6qdARsnP0jcXJe230yJLmRUynzp+y
        3pHni5mH2dS+pK6iscG8poVH0iFd1VfeubtHZ5aPzyaEazTjZboDRekPi9NC7UxvdYKX09cz
        fllf3NA5cuait/SXyI6jObe6F0/vnixQCz06I494HEvx9HomRV+77/iXjfiC3PL6QGvEa3t7
        cmPyf/V7WvnjR3OnTAHZhhMH7mQ4xO0LXzesn/a2px5ZV7Yz2IBFO3onmk0F4eqRShhWIBk+
        W6Uu3X/YK64aSbLftZrKL8CYIfZgoyNFDfrPYHmbmg7tSR/7YTS2oiGwJ8g2f/ftgZ/Oj2+J
        HlNq/Sici2MU2zAzx/wHwVEBK4IEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSnG54qX28wYrTLBZre4+yWLydu5jF
        Yv6Rc6wWV76+Z7M40HiZ0eL98i42i51X1rJYbHp8jdXiY889VovLu+awWUy8vYHdYsaPf4wW
        F0+5WmybtZzNYt2t12wWrXuPsFv8u7aRxeLR1PuMDkIeTe+PsXm8v9HK7jHr/lk2jzvnzrN5
        7Jx1l91j06pONo/73ceZPDYvqfdoPfqLxaNvyypGj82nqz0+b5IL4InisklJzcksSy3St0vg
        ypi06S5TwYeIiuerD7M3MK526mLk5JAQMJHoPLmOvYuRi0NIYDejRNf5bcwQCRmJVf1bWLsY
        OYBsYYnDh4shal4zSmye/IQJpEZYwF1iyeJmFhBbRKBS4vOcXcwgRcwCm1kk7uxZxQrRsYNR
        YuG+mWAdbAK6El97roPZvAJ2EqdXH2IEsVkEVCXe3TnLDrJNVCBSYucOS4gSQYmTM5+ALeAU
        SJVYtn8NWCuzgJnEvM0PmSFseYnmrbOhbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEy
        taA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOMq1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe3r3W
        8UK8KYmVValF+fFFpTmpxYcYpTlYlMR5bxQujBMSSE8sSc1OTS1ILYLJMnFwSjUwaSwxLqwt
        XrbpXbq46ec01tnLmvx/3GxZy8DvdGzqs1samlovFKr7P8dtcK+qi6tntZSe8+BiV17XW7Wp
        GcIn7/UoH3CqLJaMKFmg17XxuKwCv2x1q6LLLeaq9Wm3DuVsXKfgOH032/47hevOJ286Mtl/
        3eoT67Ou2+1kmui+fGPq1ebfM9RrJV/XPPvzmGVlhbNjUSfPlmPfp9pFtJtYTd+5SOLWhu7Q
        S2elNvIotehaKxp2JR2tneyyetmD7EeTzW/fbiw673kjd6F7+PWbO28oOvBIFD/5zZ8792rl
        xB1xBvu3KftIrhV4+fuHmbYzv2NW9KJ8kdl16+QDvvx8u21d4ty2Cz3iri1Mx1YeUGIpzkg0
        1GIuKk4EABwR+51hAwAA
X-CMS-MailID: 20200821071847epcas1p27d0f061d982ab0befd58889c8a1c043e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200709070649epcas1p13664bacc66a0f73443bf4d3e8940f933
References: <CGME20200709070649epcas1p13664bacc66a0f73443bf4d3e8940f933@epcas1p1.samsung.com>
        <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thank you for your version 4 patch.
I tested all 78 patches based on the next-20200708.


Dual HDMI opearation does not work normally.
flip_done timed out occurs and doesn't work.
Could you check please it.

[  105.694541] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[CRTC:64:crtc-3] flip_done timed out
[  115.934994] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[CONNECTOR:32:HDMI-A-1] flip_done timed out
[  126.174545] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[PLANE:60:plane-3] flip_done timed out


And there is a problem with 4k UDH not outputting...
So this problem worked as I fixed it like patches[1].

[1] [PATCH 0/3] drm/vc4: Support HDMI QHD or higher output


"[PATCH v4 00/78] drm/vc4: Support BCM2711 Display Pipeline" all patches.

Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>

Best regards,
Hoegeun

> Hi everyone,
>
> Here's a (pretty long) series to introduce support in the VC4 DRM driver
> for the display pipeline found in the BCM2711 (and thus the RaspberryPi 4).
>
> The main differences are that there's two HDMI controllers and that there's
> more pixelvalve now. Those pixelvalve come with a mux in the HVS that still
> have only 3 FIFOs. Both of those differences are breaking a bunch of
> expectations in the driver, so we first need a good bunch of cleanup and
> reworks to introduce support for the new controllers.
>
> Similarly, the HDMI controller has all its registers shuffled and split in
> multiple controllers now, so we need a bunch of changes to support this as
> well.
>
> Only the HDMI support is enabled for now (even though the DPI and DSI
> outputs have been tested too).
>
> Let me know if you have any comments
> Maxime
>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: devicetree@vger.kernel.org
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: linux-clk@vger.kernel.org
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
>
> Changes from v3:
>    - Rebased on top of next-20200708
>    - Added a name to the HDMI audio codec component
>    - Only disable the BCM2711 HDMI pixelvalves at boot
>    - Fixed an error in the HVS binding
>    - Fix a framebuffer size condition that was inverted
>    - Changed the channel allocation algorithm using Eric's suggestion
>    - Always write the muxing values instead of updating if needed
>    - Improved a bit the hvs_available_channels comment in the structure
>    - Change atomic_complete_commit code to use for_each_new_crtc_in_state
>    - Change the muxing code to take into account disparities between the
>      BCM2711 and previous SoCs.
>    - Only change the clock rate on BCM2711 during a modeset
>    - Fix a crash at atomic_disable
>    - Use clk_set_min_rate for the core clock too
>    - Add a few defines, and simplify the FIFO level stuff
>    - Reordered the patches according to Eric's reviews
>    - Fixed a regression with VID_CTL setting on RPI3
>
> Changes from v2:
>    - Rebased on top of next-20200526
>    - Split the firmware clock series away
>    - Removed the stuck pixel (with all the subsequent pixels being shifted
>      by one
>    - Fixed the writeback issue too.
>    - Fix the dual output
>    - Fixed the return value of phy_get_cp_current
>    - Enhanced the comment on the reset delay
>    - Increase the max width and height
>    - Made a proper Kconfig option for the DVP clock driver
>    - Fixed the alsa card name collision
>
> Changes from v1:
>    - Rebased on top of 5.7-rc1
>    - Run checkpatch
>    - Added audio support
>    - Fixed some HDMI timeouts
>    - Swiched to clk_hw_register_gate_parent_data
>    - Reorder Kconfig symbols in drivers/i2c/busses
>    - Make the firmware clocks a child of the firmware node
>    - Switch DVP clock driver to clk_hw interface
>    - constify raspberrypi_clk_data in raspberrypi_clock_property
>    - Don't mark firmware clocks as IGNORE_UNUSED
>    - Change from reset_ms to reset_us in reset-simple, and add a bit more
>      comments
>    - Remove generic clk patch to test if a NULL pointer is returned
>    - Removed misleading message in the is_prepared renaming patch commit
>      message
>    - Constify HDMI controller variants
>    - Fix a bug in the allocation size of the clk data array
>    - Added a mention in the DT binding conversion patches about the breakage
>    - Merged a few fixes from kbuild
>    - Fixed a few bisection and CEC build issues
>    - Collected Acked-by and Reviewed-by
>    - Change Dave email address to raspberrypi.com
>
> Dave Stevenson (7):
>    drm/vc4: Add support for the BCM2711 HVS5
>    drm/vc4: plane: Change LBM alignment constraint on LBM
>    drm/vc4: plane: Optimize the LBM allocation size
>    drm/vc4: hdmi: Use reg-names to retrieve the HDMI audio registers
>    drm/vc4: hdmi: Reset audio infoframe on encoder_enable if previously streaming
>    drm/vc4: hdmi: Set the b-frame marker to the match ALSA's default.
>    drm/vc4: hdmi: Add audio-related callbacks
>
> Maxime Ripard (71):
>    dt-bindings: display: Add support for the BCM2711 HVS
>    drm/vc4: hvs: Boost the core clock during modeset
>    drm/vc4: plane: Create more planes
>    drm/vc4: crtc: Deal with different number of pixel per clock
>    drm/vc4: crtc: Use a shared interrupt
>    drm/vc4: crtc: Move the cob allocation outside of bind
>    drm/vc4: crtc: Rename HVS channel to output
>    drm/vc4: crtc: Use local chan variable
>    drm/vc4: crtc: Enable and disable the PV in atomic_enable / disable
>    drm/vc4: kms: Convert to for_each_new_crtc_state
>    drm/vc4: crtc: Assign output to channel automatically
>    drm/vc4: crtc: Add FIFO depth to vc4_crtc_data
>    drm/vc4: crtc: Add function to compute FIFO level bits
>    drm/vc4: crtc: Rename HDMI encoder type to HDMI0
>    drm/vc4: crtc: Add HDMI1 encoder type
>    drm/vc4: crtc: Disable color management for HVS5
>    drm/vc4: crtc: Turn pixelvalve reset into a function
>    drm/vc4: crtc: Move PV dump to config_pv
>    drm/vc4: crtc: Move HVS init and close to a function
>    drm/vc4: crtc: Move the HVS gamma LUT setup to our init function
>    drm/vc4: hvs: Make sure our channel is reset
>    drm/vc4: crtc: Remove mode_set_nofb
>    drm/vc4: crtc: Remove redundant pixelvalve reset
>    drm/vc4: crtc: Move HVS channel init before the PV initialisation
>    drm/vc4: encoder: Add finer-grained encoder callbacks
>    drm/vc4: crtc: Add a delay after disabling the PixelValve output
>    drm/vc4: crtc: Clear the PixelValve FIFO on disable
>    drm/vc4: crtc: Clear the PixelValve FIFO during configuration
>    drm/vc4: hvs: Make the stop_channel function public
>    drm/vc4: hvs: Introduce a function to get the assigned FIFO
>    drm/vc4: crtc: Move the CRTC disable out
>    drm/vc4: drv: Disable the CRTC at boot time
>    dt-bindings: display: vc4: pv: Add BCM2711 pixel valves
>    drm/vc4: crtc: Add BCM2711 pixelvalves
>    drm/vc4: hdmi: Use debugfs private field
>    drm/vc4: hdmi: Move structure to header
>    drm/vc4: hdmi: rework connectors and encoders
>    drm/vc4: hdmi: Remove DDC argument to connector_init
>    drm/vc4: hdmi: Rename hdmi to vc4_hdmi
>    drm/vc4: hdmi: Move accessors to vc4_hdmi
>    drm/vc4: hdmi: Use local vc4_hdmi directly
>    drm/vc4: hdmi: Add container_of macros for encoders and connectors
>    drm/vc4: hdmi: Pass vc4_hdmi to CEC code
>    drm/vc4: hdmi: Retrieve the vc4_hdmi at unbind using our device
>    drm/vc4: hdmi: Remove vc4_dev hdmi pointer
>    drm/vc4: hdmi: Remove vc4_hdmi_connector
>    drm/vc4: hdmi: Introduce resource init and variant
>    drm/vc4: hdmi: Implement a register layout abstraction
>    drm/vc4: hdmi: Add reset callback
>    drm/vc4: hdmi: Add PHY init and disable function
>    drm/vc4: hdmi: Add PHY RNG enable / disable function
>    drm/vc4: hdmi: Add a CSC setup callback
>    drm/vc4: hdmi: Store the encoder type in the variant structure
>    drm/vc4: hdmi: Deal with multiple debugfs files
>    drm/vc4: hdmi: Move CEC init to its own function
>    drm/vc4: hdmi: Add CEC support flag
>    drm/vc4: hdmi: Remove unused CEC_CLOCK_DIV define
>    drm/vc4: hdmi: Rename drm_encoder pointer in mode_valid
>    drm/vc4: hdmi: Adjust HSM clock rate depending on pixel rate
>    drm/vc4: hdmi: Use clk_set_min_rate instead
>    drm/vc4: hdmi: Deal with multiple ALSA cards
>    drm/vc4: hdmi: Remove register dumps in enable
>    drm/vc4: hdmi: Always recenter the HDMI FIFO
>    drm/vc4: hdmi: Implement finer-grained hooks
>    drm/vc4: hdmi: Do the VID_CTL configuration at once
>    drm/vc4: hdmi: Switch to blank pixels when disabled
>    drm/vc4: hdmi: Support the BCM2711 HDMI controllers
>    dt-bindings: display: vc4: hdmi: Add BCM2711 HDMI controllers bindings
>    dt-bindings: display: vc4: Document BCM2711 VC5
>    drm/vc4: drv: Support BCM2711
>    ARM: dts: bcm2711: Enable the display pipeline
>
>   Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml        |  109 +++++-
>   Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml         |   18 +-
>   Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml |    5 +-
>   Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml         |    1 +-
>   arch/arm/boot/dts/bcm2711-rpi-4-b.dts                                   |   46 ++-
>   arch/arm/boot/dts/bcm2711.dtsi                                          |  115 ++++-
>   drivers/gpu/drm/vc4/Makefile                                            |    1 +-
>   drivers/gpu/drm/vc4/vc4_crtc.c                                          |  338 +++++++++++----
>   drivers/gpu/drm/vc4/vc4_drv.c                                           |    5 +-
>   drivers/gpu/drm/vc4/vc4_drv.h                                           |   43 +-
>   drivers/gpu/drm/vc4/vc4_hdmi.c                                          | 1625 +++++++++++++++++++++++++++++++++++++++++++-----------------------------
>   drivers/gpu/drm/vc4/vc4_hdmi.h                                          |  183 ++++++++-
>   drivers/gpu/drm/vc4/vc4_hdmi_phy.c                                      |  520 +++++++++++++++++++++++-
>   drivers/gpu/drm/vc4/vc4_hdmi_regs.h                                     |  442 ++++++++++++++++++++-
>   drivers/gpu/drm/vc4/vc4_hvs.c                                           |  260 +++++++-----
>   drivers/gpu/drm/vc4/vc4_kms.c                                           |  225 +++++++++-
>   drivers/gpu/drm/vc4/vc4_plane.c                                         |  222 +++++++---
>   drivers/gpu/drm/vc4/vc4_regs.h                                          |  177 +++-----
>   drivers/gpu/drm/vc4/vc4_txp.c                                           |    4 +-
>   19 files changed, 3331 insertions(+), 1008 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
>   create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi.h
>   create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi_phy.c
>   create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi_regs.h
>
> base-commit: 5bdd2824d705fb8d339d6f96e464b907c9a1553d
