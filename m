Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F392C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBA422CF8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbStSWV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgHERZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:25:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728409AbgHERPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGwlDRrUmfnCA41Wd+w3m7ULgwi2rrC2tIZF7Bi6bAQ=;
        b=JbStSWV9GFpO2a55dRse0jfAh9Jm5/6Gexio6Qi+XhwcccEX7bEWdhUS5Af4CL5Gs4xJ1W
        BpRRm4tzCj+CFxRIbf1Ztd/CJWfmltALPN7hsSdVqZ3/NuciAwspkTJyIRU57VF69s1lRA
        0YWSAKQKzAnyGyuwJl8ewaj1KwP+c4c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-B6wn6-5sOsuIcigbfLDfUA-1; Wed, 05 Aug 2020 08:49:01 -0400
X-MC-Unique: B6wn6-5sOsuIcigbfLDfUA-1
Received: by mail-wr1-f72.google.com with SMTP id e12so13592900wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CGwlDRrUmfnCA41Wd+w3m7ULgwi2rrC2tIZF7Bi6bAQ=;
        b=WjRQQdyhc4WqN+W3SKZTjXT+DfArT65ds3KNqsS+CDEu58yDTHvbadwU4s+ondG80k
         e1bUpp+Hhv2VEBgMddBhWlpN9ZrnahIQlF8gwBl6n7E/tdV/P7mqmQOTXMngfohDpOys
         a5btxNhuXM0yqnaG/ii5UPK2vGQ+qMEzXz6zGBbMPe6R2M4QVqQGcr+V+jrQHTVOxLOa
         WQsi0SnxMpSL8xK5jsC0PKUVqJSVXeG6ScgqVQqyzJ+6GZwEou5t03Oly+wf3V/oZgRH
         EZU206BdiL8pXv5/XOyPYy0hm6R393jvPSO4f1+FZrCT0WPqXkE5VuKfU7Qsd1ESOyfe
         oBfQ==
X-Gm-Message-State: AOAM532uasULUO+FUfSqXU7dCDsdH+dc4/N5EJMPTIxsUPIzWsqXuSvx
        kjQn4I7CA5tHeS2ncF9IQD0/dTrC+EnwkmlQ/nhIE8Jef8LAPpl1e7rxe7ejt7qZfc2+AbcnsnR
        KhpB6b2tb4+66gSkepr+6k2Zn
X-Received: by 2002:a5d:514e:: with SMTP id u14mr2640354wrt.20.1596631739255;
        Wed, 05 Aug 2020 05:48:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIfLAW5njE7a7QOoY9G/jGqPTLFGFvmbwKBzpe7hgcGZRx5BGUtja6apmF1sj4UATGv+PozQ==
X-Received: by 2002:a5d:514e:: with SMTP id u14mr2640334wrt.20.1596631738915;
        Wed, 05 Aug 2020 05:48:58 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id f15sm2777347wrt.80.2020.08.05.05.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 05:48:57 -0700 (PDT)
Date:   Wed, 5 Aug 2020 08:48:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805084604-mutt-send-email-mst@kernel.org>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200805075856-mutt-send-email-mst@kernel.org>
 <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 03:40:54PM +0300, Eli Cohen wrote:
> On Wed, Aug 05, 2020 at 08:00:55AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Aug 04, 2020 at 07:20:36PM +0300, Eli Cohen wrote:
> > > Hi Michael,
> > > please note that this series depends on mlx5 core device driver patches
> > > in mlx5-next branch in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
> > > 
> > > git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 
> > > 
> > > They also depend Jason Wang's patches: https://lkml.org/lkml/2020/7/1/301
> > 
> > So if I apply this to linux-next branch of my tree, I get:
> > 
> 
> Did you merge this?:
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next


I can only merge this tree if no one else will. Linus does not like
getting same patches through two trees.

Is this the case? Is mlx5-next going to be merged through
my tree in this cycle?


> > 
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND  objtool
> >   CHK     include/generated/compile.h
> >   CC [M]  drivers/vdpa/mlx5/net/main.o
> > In file included from ./include/linux/swab.h:5,
> >                  from ./include/uapi/linux/byteorder/little_endian.h:13,
> >                  from ./include/linux/byteorder/little_endian.h:5,
> >                  from ./arch/x86/include/uapi/asm/byteorder.h:5,
> >                  from ./include/asm-generic/bitops/le.h:6,
> >                  from ./arch/x86/include/asm/bitops.h:395,
> >                  from ./include/linux/bitops.h:29,
> >                  from ./include/linux/kernel.h:12,
> >                  from ./include/linux/list.h:9,
> >                  from ./include/linux/module.h:12,
> >                  from drivers/vdpa/mlx5/net/main.c:4:
> > drivers/vdpa/mlx5/net/main.c: In function ‘required_caps_supported’:
> > ././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
> >   129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
> >       |                                   ^~~~~~~~~~~~~~~~~~
> > ./include/uapi/linux/swab.h:115:54: note: in definition of macro ‘__swab32’
> >   115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
> >       |                                                      ^
> > ./include/linux/byteorder/generic.h:95:21: note: in expansion of macro ‘__be32_to_cpu’
> >    95 | #define be32_to_cpu __be32_to_cpu
> >       |                     ^~~~~~~~~~~~~
> > ./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
> >    17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
> >       |                                ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
> >    51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
> >       |                                   ^~~~~~~~
> > ./include/linux/mlx5/device.h:53:34: note: in expansion of macro ‘__mlx5_bit_off’
> >    53 | #define __mlx5_dw_off(typ, fld) (__mlx5_bit_off(typ, fld) / 32)
> >       |                                  ^~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:96:1: note: in expansion of macro ‘__mlx5_dw_off’
> >    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
> >       | ^~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
> >  1355 |  MLX5_GET(device_virtio_emulation_cap, \
> >       |  ^~~~~~~~
> > drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
> >    24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
> >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from ./include/linux/mlx5/driver.h:52,
> >                  from drivers/vdpa/mlx5/net/main.c:5:
> > ./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
> >    50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
> >       |                                                         ^~
> > ./include/linux/mlx5/device.h:56:43: note: in expansion of macro ‘__mlx5_bit_sz’
> >    56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
> >       |                                           ^~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
> >    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
> >       |                              ^~~~~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
> >  1355 |  MLX5_GET(device_virtio_emulation_cap, \
> >       |  ^~~~~~~~
> > drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
> >    24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
> >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from <command-line>:
> > ././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
> >   129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
> >       |                                   ^~~~~~~~~~~~~~~~~~
> > ./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
> >    17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
> >       |                                ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
> >    51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
> >       |                                   ^~~~~~~~
> > ./include/linux/mlx5/device.h:56:70: note: in expansion of macro ‘__mlx5_bit_off’
> >    56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
> >       |                                                                      ^~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
> >    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
> >       |                              ^~~~~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
> >  1355 |  MLX5_GET(device_virtio_emulation_cap, \
> >       |  ^~~~~~~~
> > drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
> >    24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
> >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from ./include/linux/mlx5/driver.h:52,
> >                  from drivers/vdpa/mlx5/net/main.c:5:
> > ./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
> >    50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
> >       |                                                         ^~
> > ./include/linux/mlx5/device.h:57:47: note: in expansion of macro ‘__mlx5_bit_sz’
> >    57 | #define __mlx5_mask(typ, fld) ((u32)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
> >       |                                               ^~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:97:1: note: in expansion of macro ‘__mlx5_mask’
> >    97 | __mlx5_mask(typ, fld))
> >       | ^~~~~~~~~~~
> > ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
> >  1355 |  MLX5_GET(device_virtio_emulation_cap, \
> >       |  ^~~~~~~~
> > drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
> >    24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
> >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from ./include/linux/swab.h:5,
> >                  from ./include/uapi/linux/byteorder/little_endian.h:13,
> >                  from ./include/linux/byteorder/little_endian.h:5,
> >                  from ./arch/x86/include/uapi/asm/byteorder.h:5,
> >                  from ./include/asm-generic/bitops/le.h:6,
> >                  from ./arch/x86/include/asm/bitops.h:395,
> >                  from ./include/linux/bitops.h:29,
> >                  from ./include/linux/kernel.h:12,
> >                  from ./include/linux/list.h:9,
> >                  from ./include/linux/module.h:12,
> >                  from drivers/vdpa/mlx5/net/main.c:4:
> > ././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
> >   129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
> >       |                                   ^~~~~~~~~~~~~~~~~~
> > ./include/uapi/linux/swab.h:115:54: note: in definition of macro ‘__swab32’
> >   115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
> >       |                                                      ^
> > ./include/linux/byteorder/generic.h:95:21: note: in expansion of macro ‘__be32_to_cpu’
> >    95 | #define be32_to_cpu __be32_to_cpu
> >       |                     ^~~~~~~~~~~~~
> > ./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
> >    17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
> >       |                                ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
> >    51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
> >       |                                   ^~~~~~~~
> > ./include/linux/mlx5/device.h:53:34: note: in expansion of macro ‘__mlx5_bit_off’
> >    53 | #define __mlx5_dw_off(typ, fld) (__mlx5_bit_off(typ, fld) / 32)
> >       |                                  ^~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:96:1: note: in expansion of macro ‘__mlx5_dw_off’
> >    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
> >       | ^~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
> >  1355 |  MLX5_GET(device_virtio_emulation_cap, \
> >       |  ^~~~~~~~
> > drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
> >    28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
> >       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from ./include/linux/mlx5/driver.h:52,
> >                  from drivers/vdpa/mlx5/net/main.c:5:
> > ./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
> >    50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
> >       |                                                         ^~
> > ./include/linux/mlx5/device.h:56:43: note: in expansion of macro ‘__mlx5_bit_sz’
> >    56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
> >       |                                           ^~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
> >    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
> >       |                              ^~~~~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
> >  1355 |  MLX5_GET(device_virtio_emulation_cap, \
> >       |  ^~~~~~~~
> > drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
> >    28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
> >       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from <command-line>:
> > ././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
> >   129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
> >       |                                   ^~~~~~~~~~~~~~~~~~
> > ./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
> >    17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
> >       |                                ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
> >    51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
> >       |                                   ^~~~~~~~
> > ./include/linux/mlx5/device.h:56:70: note: in expansion of macro ‘__mlx5_bit_off’
> >    56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
> >       |                                                                      ^~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
> >    96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
> >       |                              ^~~~~~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
> >  1355 |  MLX5_GET(device_virtio_emulation_cap, \
> >       |  ^~~~~~~~
> > drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
> >    28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
> >       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from ./include/linux/mlx5/driver.h:52,
> >                  from drivers/vdpa/mlx5/net/main.c:5:
> > ./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
> >    50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
> >       |                                                         ^~
> > ./include/linux/mlx5/device.h:57:47: note: in expansion of macro ‘__mlx5_bit_sz’
> >    57 | #define __mlx5_mask(typ, fld) ((u32)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
> >       |                                               ^~~~~~~~~~~~~
> > ./include/linux/mlx5/device.h:97:1: note: in expansion of macro ‘__mlx5_mask’
> >    97 | __mlx5_mask(typ, fld))
> >       | ^~~~~~~~~~~
> > ./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
> >  1355 |  MLX5_GET(device_virtio_emulation_cap, \
> >       |  ^~~~~~~~
> > drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
> >    28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
> >       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/vdpa/mlx5/net/main.c: At top level:
> > drivers/vdpa/mlx5/net/main.c:62:14: error: ‘MLX5_INTERFACE_PROTOCOL_VDPA’ undeclared here (not in a function); did you mean ‘MLX5_INTERFACE_PROTOCOL_ETH’?
> >    62 |  .protocol = MLX5_INTERFACE_PROTOCOL_VDPA,
> >       |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |              MLX5_INTERFACE_PROTOCOL_ETH
> > make[3]: *** [scripts/Makefile.build:281: drivers/vdpa/mlx5/net/main.o] Error 1
> > make[2]: *** [scripts/Makefile.build:497: drivers/vdpa/mlx5] Error 2
> > make[1]: *** [scripts/Makefile.build:497: drivers/vdpa] Error 2
> > make: *** [Makefile:1756: drivers] Error 2
> > 
> > 
> > I am guessing this is because of the missing dependency, right?
> > So what's the plan for merging this?
> > 
> > 
> > -- 
> > MST
> > 

