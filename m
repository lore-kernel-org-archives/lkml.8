Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F025AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD88D206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OyU/urzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgIANaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgIANR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:17:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E3C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 06:17:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o21so1140935wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c3ehO3Z+4dyEui9duwbWXkBuxAPi9sIxZfZ/t7dGf3I=;
        b=OyU/urzG49mJdQ3AnaIDnTvpCzw5xBNB4XxzD9Saqqw8M87ad+NF+DQWSMR7eK1/Br
         v2LI9B+QPcsiYIeXLqPtInIyxPXUO0EoMt/yq2GRJY4DRbPgZQ7g/8B+NjEkysGSpvkv
         p1/xJWtT+TPwOtWeUiTYQGiHysAfMAYjTQSfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=c3ehO3Z+4dyEui9duwbWXkBuxAPi9sIxZfZ/t7dGf3I=;
        b=DTn8hdOow7mIOShjOMCIgoJ160jkdTOwjzb2OZPg/IStTMQ9mZrMpuxe+SIsTA0DVY
         lsiVdJlS1WptkZbU+OjzCrJyN6a+XDyNF2WMv5rA4YMlShmHKqzgh7Rk5kCAIi9sbUcp
         e4UfDRZKh7iphGiXamkYobSFP5fci0PxZq1V3JhIfxzcxh1ynL46ozAG4Un50t1kfPlT
         1i8DEQoXYrshdEbcEi5fdm5X15HbB3R3UfgHnrdgf+J/nsBNEqobTCbNQo4xbF8ahzO+
         xK86eAETMoS9mpA4y2wY7pdV9agMyh5U+J0xOUYMcPZq7aqul2QAxrYoMgGtneWdGBOn
         QkwA==
X-Gm-Message-State: AOAM531K71JWbD4/HjI2BOKNkGh4f0ymhbJojFsck4uyCa8OL36dqOAu
        StmI454Udme0UD70NJw5HjCzlA==
X-Google-Smtp-Source: ABdhPJw+AQsqZrPQ3vQ9+70MwHoh5ZeVUw4BIUBh98gguv7snZc20xCl9526zEZ1g2PhOuxe2JBKBw==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr1765942wmc.130.1598966241324;
        Tue, 01 Sep 2020 06:17:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i3sm2316965wrs.4.2020.09.01.06.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 06:17:20 -0700 (PDT)
Date:   Tue, 1 Sep 2020 15:17:18 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     crj <algea.cao@rock-chips.com>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, mripard@kernel.org,
        tzimmermann@suse.de, linux-kernel@vger.kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        maarten.lankhorst@linux.intel.com, daniel@ffwll.ch,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm: Parse Colorimetry data block from EDID
Message-ID: <20200901131718.GC2352366@phenom.ffwll.local>
Mail-Followup-To: crj <algea.cao@rock-chips.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        mripard@kernel.org, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        linux-rockchip@lists.infradead.org
References: <20200826142328.131144-1-algea.cao@rock-chips.com>
 <20200827105701.GS6112@intel.com>
 <4cadf318-cfc3-92d6-6219-170166db94ce@rock-chips.com>
 <20200831195316.GC6112@intel.com>
 <7a800d9f-2679-73a6-f3d3-dd6cfa829790@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a800d9f-2679-73a6-f3d3-dd6cfa829790@rock-chips.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:30:17PM +0800, crj wrote:
> Hi,
> 
> 在 2020/9/1 3:53, Ville Syrjälä 写道:
> > On Fri, Aug 28, 2020 at 09:07:13AM +0800, crj wrote:
> > > Hi Ville Syrjälä,
> > > 
> > > 在 2020/8/27 18:57, Ville Syrjälä 写道:
> > > > On Wed, Aug 26, 2020 at 10:23:28PM +0800, Algea Cao wrote:
> > > > > CEA 861.3 spec adds colorimetry data block for HDMI.
> > > > > Parsing the block to get the colorimetry data from
> > > > > panel.
> > > > And what exactly do you want to do with that data?
> > > 
> > > We can get colorimetry data block from edid then support
> > > 
> > > HDMI colorimetry such as BT2020.
> > But what do you want to do with it? The patch does nothing
> > functional.
> 
> If we want to output BT2020 in HDMI driver, we can know whether TV support
> BT2020
> 
> via connector->display_info.hdmi.colorimetry. If TV don't support BT2020,
> HDMI shouldn't
> 
> ouput in BT2020.

You need to include these driver patches in your series, not just the core
changes. We don't review/merge just core enabling patches, we need an
entire functional slice.
-Daniel

> 
> > > > > Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> > > > > ---
> > > > > 
> > > > >    drivers/gpu/drm/drm_edid.c  | 45 +++++++++++++++++++++++++++++++++++++
> > > > >    include/drm/drm_connector.h |  3 +++
> > > > >    include/drm/drm_edid.h      | 14 ++++++++++++
> > > > >    3 files changed, 62 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > > > > index 31496b6cfc56..67e607c04492 100644
> > > > > --- a/drivers/gpu/drm/drm_edid.c
> > > > > +++ b/drivers/gpu/drm/drm_edid.c
> > > > > @@ -3223,6 +3223,7 @@ add_detailed_modes(struct drm_connector *connector, struct edid *edid,
> > > > >    #define VIDEO_BLOCK     0x02
> > > > >    #define VENDOR_BLOCK    0x03
> > > > >    #define SPEAKER_BLOCK	0x04
> > > > > +#define COLORIMETRY_DATA_BLOCK		0x5
> > > > >    #define HDR_STATIC_METADATA_BLOCK	0x6
> > > > >    #define USE_EXTENDED_TAG 0x07
> > > > >    #define EXT_VIDEO_CAPABILITY_BLOCK 0x00
> > > > > @@ -4309,6 +4310,48 @@ static void fixup_detailed_cea_mode_clock(struct drm_display_mode *mode)
> > > > >    	mode->clock = clock;
> > > > >    }
> > > > > +static bool cea_db_is_hdmi_colorimetry_data_block(const u8 *db)
> > > > > +{
> > > > > +	if (cea_db_tag(db) != USE_EXTENDED_TAG)
> > > > > +		return false;
> > > > > +
> > > > > +	if (db[1] != COLORIMETRY_DATA_BLOCK)
> > > > > +		return false;
> > > > > +
> > > > > +	if (cea_db_payload_len(db) < 2)
> > > > > +		return false;
> > > > > +
> > > > > +	return true;
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +drm_parse_colorimetry_data_block(struct drm_connector *connector, const u8 *db)
> > > > > +{
> > > > > +	struct drm_hdmi_info *info = &connector->display_info.hdmi;
> > > > > +
> > > > > +	if (db[2] & DRM_EDID_CLRMETRY_xvYCC_601)
> > > > > +		info->colorimetry |= DRM_EDID_CLRMETRY_xvYCC_601;
> > > > > +	if (db[2] & DRM_EDID_CLRMETRY_xvYCC_709)
> > > > > +		info->colorimetry |= DRM_EDID_CLRMETRY_xvYCC_709;
> > > > > +	if (db[2] & DRM_EDID_CLRMETRY_sYCC_601)
> > > > > +		info->colorimetry |= DRM_EDID_CLRMETRY_sYCC_601;
> > > > > +	if (db[2] & DRM_EDID_CLRMETRY_ADBYCC_601)
> > > > > +		info->colorimetry |= DRM_EDID_CLRMETRY_ADBYCC_601;
> > > > > +	if (db[2] & DRM_EDID_CLRMETRY_ADB_RGB)
> > > > > +		info->colorimetry |= DRM_EDID_CLRMETRY_ADB_RGB;
> > > > > +	if (db[2] & DRM_EDID_CLRMETRY_BT2020_CYCC)
> > > > > +		info->colorimetry |= DRM_EDID_CLRMETRY_BT2020_CYCC;
> > > > > +	if (db[2] & DRM_EDID_CLRMETRY_BT2020_YCC)
> > > > > +		info->colorimetry |= DRM_EDID_CLRMETRY_BT2020_YCC;
> > > > > +	if (db[2] & DRM_EDID_CLRMETRY_BT2020_RGB)
> > > > > +		info->colorimetry |= DRM_EDID_CLRMETRY_BT2020_RGB;
> > > > > +	/* Byte 4 Bit 7: DCI-P3 */
> > > > > +	if (db[3] & BIT(7))
> > > > > +		info->colorimetry |= DRM_EDID_CLRMETRY_DCI_P3;
> > > > > +
> > > > > +	DRM_DEBUG_KMS("Supported Colorimetry 0x%x\n", info->colorimetry);
> > > > > +}
> > > > > +
> > > > >    static bool cea_db_is_hdmi_hdr_metadata_block(const u8 *db)
> > > > >    {
> > > > >    	if (cea_db_tag(db) != USE_EXTENDED_TAG)
> > > > > @@ -4994,6 +5037,8 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
> > > > >    			drm_parse_vcdb(connector, db);
> > > > >    		if (cea_db_is_hdmi_hdr_metadata_block(db))
> > > > >    			drm_parse_hdr_metadata_block(connector, db);
> > > > > +		if (cea_db_is_hdmi_colorimetry_data_block(db))
> > > > > +			drm_parse_colorimetry_data_block(connector, db);
> > > > >    	}
> > > > >    }
> > > > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > > > > index af145608b5ed..d599c3b9e881 100644
> > > > > --- a/include/drm/drm_connector.h
> > > > > +++ b/include/drm/drm_connector.h
> > > > > @@ -207,6 +207,9 @@ struct drm_hdmi_info {
> > > > >    	/** @y420_dc_modes: bitmap of deep color support index */
> > > > >    	u8 y420_dc_modes;
> > > > > +
> > > > > +	/* @colorimetry: bitmap of supported colorimetry modes */
> > > > > +	u16 colorimetry;
> > > > >    };
> > > > >    /**
> > > > > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > > > > index cfa4f5af49af..98fa78c2f82d 100644
> > > > > --- a/include/drm/drm_edid.h
> > > > > +++ b/include/drm/drm_edid.h
> > > > > @@ -229,6 +229,20 @@ struct detailed_timing {
> > > > >    				    DRM_EDID_YCBCR420_DC_36 | \
> > > > >    				    DRM_EDID_YCBCR420_DC_30)
> > > > > +/*
> > > > > + * Supported Colorimetry from colorimetry data block
> > > > > + * as per CEA 861-G spec
> > > > > + */
> > > > > +#define DRM_EDID_CLRMETRY_xvYCC_601   (1 << 0)
> > > > > +#define DRM_EDID_CLRMETRY_xvYCC_709   (1 << 1)
> > > > > +#define DRM_EDID_CLRMETRY_sYCC_601    (1 << 2)
> > > > > +#define DRM_EDID_CLRMETRY_ADBYCC_601  (1 << 3)
> > > > > +#define DRM_EDID_CLRMETRY_ADB_RGB     (1 << 4)
> > > > > +#define DRM_EDID_CLRMETRY_BT2020_CYCC (1 << 5)
> > > > > +#define DRM_EDID_CLRMETRY_BT2020_YCC  (1 << 6)
> > > > > +#define DRM_EDID_CLRMETRY_BT2020_RGB  (1 << 7)
> > > > > +#define DRM_EDID_CLRMETRY_DCI_P3      (1 << 15)
> > > > > +
> > > > >    /* ELD Header Block */
> > > > >    #define DRM_ELD_HEADER_BLOCK_SIZE	4
> > > > > -- 
> > > > > 2.25.1
> > > > > 
> > > > > 
> > > > > 
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
