Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB513C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFAB72078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTgQdJ96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgDTTH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726688AbgDTTH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:07:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC49C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:07:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so11252005ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKq6Q8RhG/Mknjv1EO22iG+3+Ph0W9R1eR/bro3elSs=;
        b=eTgQdJ96yAD9MGh67Fz2Mpvt4RUaEAZn0Dg64jYvO5oSIh/WhYWEBImunfq/KHu7dD
         fvniThbiwsBYZKoqRbLAm+EuMp5EpEN3uUqjNNyDBTWygAKFq5QmuPujRSOrTOs05S3Z
         8ELLNt1+Y7ThGLP5r7gfvObrDf6zx8upb+Fozm4udX8fTa9OQW62VBO4EidSSobsjV0E
         k4RgOwJ47glE1wcQ4d71IyTc5kO9ajWzbbk4k1CmFOfDBWFBZrrk5jTVvAy2zfdTWTbx
         SOCtynl04DsVxsMAFFOGb2WI4deujt1VkzfYFgN0xwU63Yayg9CeXW0RPVmzsJFZGCa9
         yDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKq6Q8RhG/Mknjv1EO22iG+3+Ph0W9R1eR/bro3elSs=;
        b=WRmvWTr9rBFxoeZtME4hFp3TdNSGjy82B+5Kp3R7BIXjo8NOZTIAtXnlGfSUxhPRyM
         +JjRIAhU35RmGQRGynnABpa2YqZs/zpaFxwR6AD3fgI1dVnsWDguDj1f9m6+cnj1sG8z
         HBSe/8+8HrvIOA1eHgOGXVgsqEv7WXQVgCRuuPPt9WW9CRzPoQa0q42GAJ9Uxkg6XOMo
         EQ+mWQYeRyicP6yXavvxT0lNzoodFhUC3RZ09wrZ4JX8AaCVYbbMtunL7eohzJmdxRJb
         thEdzAAsCKCEDY6xtKF68BB2KWwAOqsmjIUOtHqqvBmg461c1WuWRG4puvKpqw9CgV4d
         YJSQ==
X-Gm-Message-State: AGi0PuZnpMfP1RlgWMz5Lm3DMHwGygef358BBy5kREoF7Ao8Y5V6N9lI
        HhQHTDa1C3qjDgyqR30t7ZKtQ2oUP1wXGbqA2NqbuA==
X-Google-Smtp-Source: APiQypLW+2UdJ0x7VeiX1LKbTlJvtnn3T3NW3BJKudSf2fJB1rTDEuD1N8+coV7y+K+FCVGbWmWpTJHHCskavdkVs3I=
X-Received: by 2002:a2e:7e03:: with SMTP id z3mr11116664ljc.200.1587409675138;
 Mon, 20 Apr 2020 12:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <1587406337-32317-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1587406337-32317-1-git-send-email-jrdr.linux@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Mon, 20 Apr 2020 21:07:44 +0200
Message-ID: <CAMeQTsbDWopyaYbJt-T1jVUvFezQ6xtSuQhYiXpUuLP3kOeXPg@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Remove dead code
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 8:04 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> These are dead code since 3.7. If there is no plan to use them further,
> these can be removed forever.

Thanks. Will apply to drm-misc-next.

Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c        | 31 +--------
>  drivers/gpu/drm/gma500/cdv_intel_lvds.c      | 83 -----------------------
>  drivers/gpu/drm/gma500/mdfld_intel_display.c | 31 ---------
>  drivers/gpu/drm/gma500/psb_intel_sdvo.c      | 99 ----------------------------
>  4 files changed, 1 insertion(+), 243 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index 5772b2d..a9ed372 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -1271,37 +1271,8 @@ static void cdv_intel_dp_commit(struct drm_encoder *encoder)
>         return ((l >> s) & 3) << DP_TRAIN_PRE_EMPHASIS_SHIFT;
>  }
>
> -
> -#if 0
> -static char    *voltage_names[] = {
> -       "0.4V", "0.6V", "0.8V", "1.2V"
> -};
> -static char    *pre_emph_names[] = {
> -       "0dB", "3.5dB", "6dB", "9.5dB"
> -};
> -static char    *link_train_names[] = {
> -       "pattern 1", "pattern 2", "idle", "off"
> -};
> -#endif
> -
>  #define CDV_DP_VOLTAGE_MAX         DP_TRAIN_VOLTAGE_SWING_LEVEL_3
> -/*
> -static uint8_t
> -cdv_intel_dp_pre_emphasis_max(uint8_t voltage_swing)
> -{
> -       switch (voltage_swing & DP_TRAIN_VOLTAGE_SWING_MASK) {
> -       case DP_TRAIN_VOLTAGE_SWING_400:
> -               return DP_TRAIN_PRE_EMPHASIS_6;
> -       case DP_TRAIN_VOLTAGE_SWING_600:
> -               return DP_TRAIN_PRE_EMPHASIS_6;
> -       case DP_TRAIN_VOLTAGE_SWING_800:
> -               return DP_TRAIN_PRE_EMPHASIS_3_5;
> -       case DP_TRAIN_VOLTAGE_SWING_1200:
> -       default:
> -               return DP_TRAIN_PRE_EMPHASIS_0;
> -       }
> -}
> -*/
> +
>  static void
>  cdv_intel_get_adjust_train(struct gma_encoder *encoder)
>  {
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> index ea0a5d9..dffb86e 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> @@ -72,89 +72,6 @@ static u32 cdv_intel_lvds_get_max_backlight(struct drm_device *dev)
>         return retval;
>  }
>
> -#if 0
> -/*
> - * Set LVDS backlight level by I2C command
> - */
> -static int cdv_lvds_i2c_set_brightness(struct drm_device *dev,
> -                                       unsigned int level)
> -{
> -       struct drm_psb_private *dev_priv = dev->dev_private;
> -       struct psb_intel_i2c_chan *lvds_i2c_bus = dev_priv->lvds_i2c_bus;
> -       u8 out_buf[2];
> -       unsigned int blc_i2c_brightness;
> -
> -       struct i2c_msg msgs[] = {
> -               {
> -                       .addr = lvds_i2c_bus->slave_addr,
> -                       .flags = 0,
> -                       .len = 2,
> -                       .buf = out_buf,
> -               }
> -       };
> -
> -       blc_i2c_brightness = BRIGHTNESS_MASK & ((unsigned int)level *
> -                            BRIGHTNESS_MASK /
> -                            BRIGHTNESS_MAX_LEVEL);
> -
> -       if (dev_priv->lvds_bl->pol == BLC_POLARITY_INVERSE)
> -               blc_i2c_brightness = BRIGHTNESS_MASK - blc_i2c_brightness;
> -
> -       out_buf[0] = dev_priv->lvds_bl->brightnesscmd;
> -       out_buf[1] = (u8)blc_i2c_brightness;
> -
> -       if (i2c_transfer(&lvds_i2c_bus->adapter, msgs, 1) == 1)
> -               return 0;
> -
> -       DRM_ERROR("I2C transfer error\n");
> -       return -1;
> -}
> -
> -
> -static int cdv_lvds_pwm_set_brightness(struct drm_device *dev, int level)
> -{
> -       struct drm_psb_private *dev_priv = dev->dev_private;
> -
> -       u32 max_pwm_blc;
> -       u32 blc_pwm_duty_cycle;
> -
> -       max_pwm_blc = cdv_intel_lvds_get_max_backlight(dev);
> -
> -       /*BLC_PWM_CTL Should be initiated while backlight device init*/
> -       BUG_ON((max_pwm_blc & PSB_BLC_MAX_PWM_REG_FREQ) == 0);
> -
> -       blc_pwm_duty_cycle = level * max_pwm_blc / BRIGHTNESS_MAX_LEVEL;
> -
> -       if (dev_priv->lvds_bl->pol == BLC_POLARITY_INVERSE)
> -               blc_pwm_duty_cycle = max_pwm_blc - blc_pwm_duty_cycle;
> -
> -       blc_pwm_duty_cycle &= PSB_BACKLIGHT_PWM_POLARITY_BIT_CLEAR;
> -       REG_WRITE(BLC_PWM_CTL,
> -                 (max_pwm_blc << PSB_BACKLIGHT_PWM_CTL_SHIFT) |
> -                 (blc_pwm_duty_cycle));
> -
> -       return 0;
> -}
> -
> -/*
> - * Set LVDS backlight level either by I2C or PWM
> - */
> -void cdv_intel_lvds_set_brightness(struct drm_device *dev, int level)
> -{
> -       struct drm_psb_private *dev_priv = dev->dev_private;
> -
> -       if (!dev_priv->lvds_bl) {
> -               DRM_ERROR("NO LVDS Backlight Info\n");
> -               return;
> -       }
> -
> -       if (dev_priv->lvds_bl->type == BLC_I2C_TYPE)
> -               cdv_lvds_i2c_set_brightness(dev, level);
> -       else
> -               cdv_lvds_pwm_set_brightness(dev, level);
> -}
> -#endif
> -
>  /**
>   * Sets the backlight level.
>   *
> diff --git a/drivers/gpu/drm/gma500/mdfld_intel_display.c b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> index 4fff110..aae2d35 100644
> --- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
> +++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> @@ -658,16 +658,6 @@ static int mdfld_crtc_mode_set(struct drm_crtc *crtc,
>
>         dev_dbg(dev->dev, "pipe = 0x%x\n", pipe);
>
> -#if 0
> -       if (pipe == 1) {
> -               if (!gma_power_begin(dev, true))
> -                       return 0;
> -               android_hdmi_crtc_mode_set(crtc, mode, adjusted_mode,
> -                       x, y, old_fb);
> -               goto mrst_crtc_mode_set_exit;
> -       }
> -#endif
> -
>         ret = check_fb(crtc->primary->fb);
>         if (ret)
>                 return ret;
> @@ -918,14 +908,6 @@ static int mdfld_crtc_mode_set(struct drm_crtc *crtc,
>                 }
>                 dpll = 0;
>
> -#if 0 /* FIXME revisit later */
> -               if (ksel == KSEL_CRYSTAL_19 || ksel == KSEL_BYPASS_19 ||
> -                                               ksel == KSEL_BYPASS_25)
> -                       dpll &= ~MDFLD_INPUT_REF_SEL;
> -               else if (ksel == KSEL_BYPASS_83_100)
> -                       dpll |= MDFLD_INPUT_REF_SEL;
> -#endif /* FIXME revisit later */
> -
>                 if (is_hdmi)
>                         dpll |= MDFLD_VCO_SEL;
>
> @@ -935,20 +917,7 @@ static int mdfld_crtc_mode_set(struct drm_crtc *crtc,
>                 /* compute bitmask from p1 value */
>                 dpll |= (1 << (clock.p1 - 2)) << 17;
>
> -#if 0 /* 1080p30 & 720p */
> -               dpll = 0x00050000;
> -               fp = 0x000001be;
> -#endif
> -#if 0 /* 480p */
> -               dpll = 0x02010000;
> -               fp = 0x000000d2;
> -#endif
>         } else {
> -#if 0 /*DBI_TPO_480x864*/
> -               dpll = 0x00020000;
> -               fp = 0x00000156;
> -#endif /* DBI_TPO_480x864 */ /* get from spec. */
> -
>                 dpll = 0x00800000;
>                 fp = 0x000000c1;
>         }
> diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
> index 264d7ad..68fb3d7 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
> @@ -864,36 +864,6 @@ static bool psb_intel_sdvo_set_avi_infoframe(struct psb_intel_sdvo *psb_intel_sd
>         DRM_INFO("HDMI is not supported yet");
>
>         return false;
> -#if 0
> -       struct dip_infoframe avi_if = {
> -               .type = DIP_TYPE_AVI,
> -               .ver = DIP_VERSION_AVI,
> -               .len = DIP_LEN_AVI,
> -       };
> -       uint8_t tx_rate = SDVO_HBUF_TX_VSYNC;
> -       uint8_t set_buf_index[2] = { 1, 0 };
> -       uint64_t *data = (uint64_t *)&avi_if;
> -       unsigned i;
> -
> -       intel_dip_infoframe_csum(&avi_if);
> -
> -       if (!psb_intel_sdvo_set_value(psb_intel_sdvo,
> -                                 SDVO_CMD_SET_HBUF_INDEX,
> -                                 set_buf_index, 2))
> -               return false;
> -
> -       for (i = 0; i < sizeof(avi_if); i += 8) {
> -               if (!psb_intel_sdvo_set_value(psb_intel_sdvo,
> -                                         SDVO_CMD_SET_HBUF_DATA,
> -                                         data, 8))
> -                       return false;
> -               data++;
> -       }
> -
> -       return psb_intel_sdvo_set_value(psb_intel_sdvo,
> -                                   SDVO_CMD_SET_HBUF_TXRATE,
> -                                   &tx_rate, 1);
> -#endif
>  }
>
>  static bool psb_intel_sdvo_set_tv_format(struct psb_intel_sdvo *psb_intel_sdvo)
> @@ -1227,75 +1197,6 @@ static bool psb_intel_sdvo_get_capabilities(struct psb_intel_sdvo *psb_intel_sdv
>         return true;
>  }
>
> -/* No use! */
> -#if 0
> -struct drm_connector* psb_intel_sdvo_find(struct drm_device *dev, int sdvoB)
> -{
> -       struct drm_connector *connector = NULL;
> -       struct psb_intel_sdvo *iout = NULL;
> -       struct psb_intel_sdvo *sdvo;
> -
> -       /* find the sdvo connector */
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
> -               iout = to_psb_intel_sdvo(connector);
> -
> -               if (iout->type != INTEL_OUTPUT_SDVO)
> -                       continue;
> -
> -               sdvo = iout->dev_priv;
> -
> -               if (sdvo->sdvo_reg == SDVOB && sdvoB)
> -                       return connector;
> -
> -               if (sdvo->sdvo_reg == SDVOC && !sdvoB)
> -                       return connector;
> -
> -       }
> -
> -       return NULL;
> -}
> -
> -int psb_intel_sdvo_supports_hotplug(struct drm_connector *connector)
> -{
> -       u8 response[2];
> -       u8 status;
> -       struct psb_intel_sdvo *psb_intel_sdvo;
> -       DRM_DEBUG_KMS("\n");
> -
> -       if (!connector)
> -               return 0;
> -
> -       psb_intel_sdvo = to_psb_intel_sdvo(connector);
> -
> -       return psb_intel_sdvo_get_value(psb_intel_sdvo, SDVO_CMD_GET_HOT_PLUG_SUPPORT,
> -                                   &response, 2) && response[0];
> -}
> -
> -void psb_intel_sdvo_set_hotplug(struct drm_connector *connector, int on)
> -{
> -       u8 response[2];
> -       u8 status;
> -       struct psb_intel_sdvo *psb_intel_sdvo = to_psb_intel_sdvo(connector);
> -
> -       psb_intel_sdvo_write_cmd(psb_intel_sdvo, SDVO_CMD_GET_ACTIVE_HOT_PLUG, NULL, 0);
> -       psb_intel_sdvo_read_response(psb_intel_sdvo, &response, 2);
> -
> -       if (on) {
> -               psb_intel_sdvo_write_cmd(psb_intel_sdvo, SDVO_CMD_GET_HOT_PLUG_SUPPORT, NULL, 0);
> -               status = psb_intel_sdvo_read_response(psb_intel_sdvo, &response, 2);
> -
> -               psb_intel_sdvo_write_cmd(psb_intel_sdvo, SDVO_CMD_SET_ACTIVE_HOT_PLUG, &response, 2);
> -       } else {
> -               response[0] = 0;
> -               response[1] = 0;
> -               psb_intel_sdvo_write_cmd(psb_intel_sdvo, SDVO_CMD_SET_ACTIVE_HOT_PLUG, &response, 2);
> -       }
> -
> -       psb_intel_sdvo_write_cmd(psb_intel_sdvo, SDVO_CMD_GET_ACTIVE_HOT_PLUG, NULL, 0);
> -       psb_intel_sdvo_read_response(psb_intel_sdvo, &response, 2);
> -}
> -#endif
> -
>  static bool
>  psb_intel_sdvo_multifunc_encoder(struct psb_intel_sdvo *psb_intel_sdvo)
>  {
> --
> 1.9.1
>
