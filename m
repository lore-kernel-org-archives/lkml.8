Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB90DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A60204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="s+tFWIJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIBJqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgIBJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:46:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C508DC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:46:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l9so3827216wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jX2ecA2PJy/6cJDE/ynYXDewujYCxQrA9LGe6p7fwa0=;
        b=s+tFWIJVIBL61p7DDHaqPAy9Y1On3xF+O5zL/CRvF1TShz2kOVXGa0BfN+4C08nZLe
         FSleXSBrFmWZSt8tJw3nm3UPjrvaW2QGxylwvCLqLRc6q01cfw9J/FXwy/gpahD+1Nu/
         eW1lgtOJD37BSpZxfm/TiaddOWbPmD95FHak3Xdf8EI2RLQPdCSa5EVbubyubg/xilUJ
         reN4hcojOON3o+u4tA3r1+6iv3b2Z4WszZr/oZd0iN6FiQWSa1bSgSLEVLVkvOsHoU3M
         Jx9lkoZv7VH4Tsxj3yJpbsPwI8TbO61B12Ar7mrvrZTbc03O5My6ek8ALq4moGm5Yvll
         tJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jX2ecA2PJy/6cJDE/ynYXDewujYCxQrA9LGe6p7fwa0=;
        b=aanwv6ivgiPMAmRBd4fmrrGXG5ps75OCJstIyaXNhcD+QNTQ0tlPz+Jb9IdYd48utW
         n6tbFqi+1qr0CcR3PTPLzbNUZZ8x/aO5wr8p2TmWy/3eVMCriRgwYTBBe1ZVS4Whi0HO
         PcxBKZa6FXD1bBiTudfVMVreJ6ees43Xq44irq0E7uuDZ/oQ9hb+gn4tivAOvoVPVhCG
         R0FAn3n+SDqJ7/xMkqArQbywAkw1/ZHy+wAmxRCwmdW24nKexmfA9rmJlyM27BDel5h+
         KzQ6GxVAV60k0efWrr758mpLMJNCnDZ2cNnLefMAkbsbm00lmjYwR1iSR0txxVSnhy7t
         HKlA==
X-Gm-Message-State: AOAM533xsCzkZKkGVnMl3MgTXMTBhGOivPKh3eGGwPZulLV4F4B/Xd+2
        igHZiApXyLLv0dOGlwf4K4egGw==
X-Google-Smtp-Source: ABdhPJyRzryUcwqo75TyJ2PL+JQ/4k6riaj+13wMpTRayJKeAUcGGy58JS/hO44sgWLczW38eGZI7w==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr6291735wmb.5.1599039989403;
        Wed, 02 Sep 2020 02:46:29 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id t203sm5786576wmg.43.2020.09.02.02.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 02:46:28 -0700 (PDT)
Date:   Wed, 2 Sep 2020 11:46:27 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v3 01/14] devlink: Add reload action option
 to devlink reload command 
Message-ID: <20200902094627.GB2568@nanopsycho>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
 <1598801254-27764-2-git-send-email-moshe@mellanox.com>
 <20200831121501.GD3794@nanopsycho.orion>
 <9fffbe80-9a2a-33de-2e11-24be34648686@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fffbe80-9a2a-33de-2e11-24be34648686@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Sep 01, 2020 at 09:43:00PM CEST, moshe@nvidia.com wrote:
>
>On 8/31/2020 3:15 PM, Jiri Pirko wrote:
>> Sun, Aug 30, 2020 at 05:27:21PM CEST, moshe@mellanox.com wrote:
>> > Add devlink reload action to allow the user to request a specific reload
>> > action. The action parameter is optional, if not specified then devlink
>> > driver re-init action is used (backward compatible).
>> > Note that when required to do firmware activation some drivers may need
>> > to reload the driver. On the other hand some drivers may need to reset
>> > the firmware to reinitialize the driver entities. Therefore, the devlink
>> > reload command returns the actions which were actually done.
>> > However, in case fw_activate_no_reset action is selected, then no other
>> > reload action is allowed.
>> > Reload actions supported are:
>> > driver_reinit: driver entities re-initialization, applying devlink-param
>> >                and devlink-resource values.
>> > fw_activate: firmware activate.
>> > fw_activate_no_reset: Activate new firmware image without any reset.
>> >                       (also known as: firmware live patching).
>> > 
>> > command examples:
>> > $devlink dev reload pci/0000:82:00.0 action driver_reinit
>> > reload_actions_done:
>> >   driver_reinit
>> > 
>> > $devlink dev reload pci/0000:82:00.0 action fw_activate
>> > reload_actions_done:
>> >   driver_reinit fw_activate
>> > 
>> > Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
>> > ---
>> > v2 -> v3:
>> > - Replace fw_live_patch action by fw_activate_no_reset
>> > - Devlink reload returns the actions done over netlink reply
>> > v1 -> v2:
>> > - Instead of reload levels driver,fw_reset,fw_live_patch have reload
>> >   actions driver_reinit,fw_activate,fw_live_patch
>> > - Remove driver default level, the action driver_reinit is the default
>> >   action for all drivers
>> > ---
>> [...]
>> 
>> 
>> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
>> > index 08d101138fbe..c42b66d88884 100644
>> > --- a/drivers/net/ethernet/mellanox/mlxsw/core.c
>> > +++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
>> > @@ -1113,7 +1113,7 @@ mlxsw_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>> > 
>> > static int
>> > mlxsw_devlink_core_bus_device_reload_down(struct devlink *devlink,
>> > -					  bool netns_change,
>> > +					  bool netns_change, enum devlink_reload_action action,
>> > 					  struct netlink_ext_ack *extack)
>> > {
>> > 	struct mlxsw_core *mlxsw_core = devlink_priv(devlink);
>> > @@ -1126,15 +1126,23 @@ mlxsw_devlink_core_bus_device_reload_down(struct devlink *devlink,
>> > }
>> > 
>> > static int
>> > -mlxsw_devlink_core_bus_device_reload_up(struct devlink *devlink,
>> > -					struct netlink_ext_ack *extack)
>> > +mlxsw_devlink_core_bus_device_reload_up(struct devlink *devlink, enum devlink_reload_action action,
>> > +					struct netlink_ext_ack *extack, unsigned long *actions_done)
>> > {
>> > 	struct mlxsw_core *mlxsw_core = devlink_priv(devlink);
>> > +	int err;
>> > 
>> > -	return mlxsw_core_bus_device_register(mlxsw_core->bus_info,
>> > -					      mlxsw_core->bus,
>> > -					      mlxsw_core->bus_priv, true,
>> > -					      devlink, extack);
>> > +	err = mlxsw_core_bus_device_register(mlxsw_core->bus_info,
>> > +					     mlxsw_core->bus,
>> > +					     mlxsw_core->bus_priv, true,
>> > +					     devlink, extack);
>> > +	if (err)
>> > +		return err;
>> > +	if (actions_done)
>> > +		*actions_done = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
>> > +				BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE);
>> > +
>> > +	return 0;
>> > }
>> > 
>> > static int mlxsw_devlink_flash_update(struct devlink *devlink,
>> > @@ -1268,6 +1276,8 @@ mlxsw_devlink_trap_policer_counter_get(struct devlink *devlink,
>> > }
>> > 
>> > static const struct devlink_ops mlxsw_devlink_ops = {
>> > +	.supported_reload_actions	= BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
>> > +					  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
>> This is confusing and open to interpretation. Does this mean that the
>> driver supports:
>> 1) REINIT && FW_ACTIVATE
>> 2) REINIT || FW_ACTIVATE
>> ?
>> 
>> Because mlxsw supports only 1. I guess that mlx5 supports both. This
>> needs to be distinguished.
>
>Mlxsw supports 1, so it supports fw_activation and performs also reinit and
>vice versa.

My point is, your bitfield does not exactly tell what the driver
supports or not.


>
>Mlx5 supports fw_activate and performs also reinit. However, it supports
>reinit without performing fw_activate.
>
>> I think you need an array of combinations. Or perhaps rather to extend
>> the enum with combinations. You kind of have it already with
>> DEVLINK_RELOAD_ACTION_FW_ACTIVATE_NO_RESET
>> 
>> Maybe we can have something like:
>> DEVLINK_RELOAD_ACTION_DRIVER_REINIT
>> DEVLINK_RELOAD_ACTION_DRIVER_REINIT_FW_ACTIVATE_RESET
>> DEVLINK_RELOAD_ACTION_FW_ACTIVATE_RESET
>> DEVLINK_RELOAD_ACTION_FW_ACTIVATE (this is the original FW_ACTIVATE_NO_RESET)
>
>The FW_ACTIVATE_NO_RESET meant also to emphasize that driver implementation
>for this one should not do any reset.
>
>So maybe we can have
>
>DEVLINK_RELOAD_ACTION_FW_ACTIVATE_RESET
>DEVLINK_RELOAD_ACTION_FW_ACTIVATE_NO_RESET

Okay.


>
>> Each has very clear meaning.
>
>
>Yes, it the driver support here is more clear.
>
>> Also, then the "actions_done" would be a simple enum, directly returned
>> to the user. No bitfield needed.
>
>
>I agree it is more clear on the driver support side, but what about the uAPI

As I said, there would be one enum value returned to the user. Clear and
simple.


>? Do we need such change there too or keep it as is, each action by itself
>and return what was performed ?

Well, I don't know. User asks for X, X should be performed, not Y or Z.
So perhaps the return value is not needed.
Just driver advertizes it supports X, Y, Z and the users says:
1) do X, driver does X
2) do Y, driver does Y
3) do Z, driver does Z
[
I think this kindof circles back to the original proposal...

>
>> 
>> > 	.reload_down		= mlxsw_devlink_core_bus_device_reload_down,
>> > 	.reload_up		= mlxsw_devlink_core_bus_device_reload_up,
>> > 	.port_type_set			= mlxsw_devlink_port_type_set,
>> [...]
