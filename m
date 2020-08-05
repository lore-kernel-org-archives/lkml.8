Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D747C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4971D22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR3i6VgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgHEQel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:34:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbgHEQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsDPAdFx/kF8hl2h3zkM2IVMaWZTOWF8sU+0wpyOWRg=;
        b=OR3i6VgOfSb6Vy0j2aoT1C36hxyGirwbpzg2gw9Frlbe1BV7i3OL6adLKZ8zQtpXGF4hSf
        moHs/IF/P1BrgD+MLi2g3wF11vaM5oPYSjeeGapLSI2v9q+U+FkldOx0g64s3VyD52vmiB
        MjsdmBI4hiZgprRfcShnEaRlzoyg/tM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-ubcTfcAbM6CSFDrei0FXlg-1; Wed, 05 Aug 2020 08:01:02 -0400
X-MC-Unique: ubcTfcAbM6CSFDrei0FXlg-1
Received: by mail-wr1-f72.google.com with SMTP id z12so13551057wrl.16
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QsDPAdFx/kF8hl2h3zkM2IVMaWZTOWF8sU+0wpyOWRg=;
        b=BWEbs1bdisnCYueoWA4FKUcAzBa74SjiWwO2ZA1I9H/18vBlU6JAp3p7trBuuszzH+
         XsxGw9EXkzyr/CiR8AQN6lGQpKLkD6eR5VuYKb+qoB9sTLiNcidWF8id3/9CJMfteLXL
         2iOouQQ2/MANhR8epgqY9YQ/esp+N204KhJNpQbHt4yf3H0CGBGd0naxQ8l4tReiJGwN
         O0mtKQmkZ1n+T3scKqVHaSHvrHQBS1/zBD3FzYTLRS/YPvHaCYdedqa1F7ChEoWiNULO
         32avgvFo8ye1xG4jFMWnyEpjPBA9AvG8/JH7Lv0GF1CxOwdmJakog/L9V7UstMChnaGJ
         hmsA==
X-Gm-Message-State: AOAM530nzvHw8wCQG9RNB7BwiNKFcCyb5zK9VTXcK4dlb2VPMsEcChT7
        jym+Na1SuJwfGhyiMMgkvLqpmRzIDExcPShkQbsgVSbUmH2UQDe9OF8kA8/Ev6C440OOqKAabVz
        vAfk+bqUIlF/rdIjTR79uxeI+
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr2715672wra.118.1596628860685;
        Wed, 05 Aug 2020 05:01:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJeW/GLMm4/M8on9IMY9UQxcXDmUJNSnCsvot7Z/+nldQ3ZZbzd97O4u5RnkvBKcsaNDBT4g==
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr2715622wra.118.1596628860131;
        Wed, 05 Aug 2020 05:01:00 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id g3sm2695848wrb.59.2020.08.05.05.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 05:00:59 -0700 (PDT)
Date:   Wed, 5 Aug 2020 08:00:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805075856-mutt-send-email-mst@kernel.org>
References: <20200804162048.22587-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804162048.22587-1-eli@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:20:36PM +0300, Eli Cohen wrote:
> Hi Michael,
> please note that this series depends on mlx5 core device driver patches
> in mlx5-next branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
> 
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 
> 
> They also depend Jason Wang's patches: https://lkml.org/lkml/2020/7/1/301

So if I apply this to linux-next branch of my tree, I get:


  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  CC [M]  drivers/vdpa/mlx5/net/main.o
In file included from ./include/linux/swab.h:5,
                 from ./include/uapi/linux/byteorder/little_endian.h:13,
                 from ./include/linux/byteorder/little_endian.h:5,
                 from ./arch/x86/include/uapi/asm/byteorder.h:5,
                 from ./include/asm-generic/bitops/le.h:6,
                 from ./arch/x86/include/asm/bitops.h:395,
                 from ./include/linux/bitops.h:29,
                 from ./include/linux/kernel.h:12,
                 from ./include/linux/list.h:9,
                 from ./include/linux/module.h:12,
                 from drivers/vdpa/mlx5/net/main.c:4:
drivers/vdpa/mlx5/net/main.c: In function ‘required_caps_supported’:
././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
  129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
      |                                   ^~~~~~~~~~~~~~~~~~
./include/uapi/linux/swab.h:115:54: note: in definition of macro ‘__swab32’
  115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
      |                                                      ^
./include/linux/byteorder/generic.h:95:21: note: in expansion of macro ‘__be32_to_cpu’
   95 | #define be32_to_cpu __be32_to_cpu
      |                     ^~~~~~~~~~~~~
./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
   17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
      |                                ^~~~~~~~~~~~~~~~~~~
./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
   51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
      |                                   ^~~~~~~~
./include/linux/mlx5/device.h:53:34: note: in expansion of macro ‘__mlx5_bit_off’
   53 | #define __mlx5_dw_off(typ, fld) (__mlx5_bit_off(typ, fld) / 32)
      |                                  ^~~~~~~~~~~~~~
./include/linux/mlx5/device.h:96:1: note: in expansion of macro ‘__mlx5_dw_off’
   96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
      | ^~~~~~~~~~~~~
./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
 1355 |  MLX5_GET(device_virtio_emulation_cap, \
      |  ^~~~~~~~
drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
   24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/mlx5/driver.h:52,
                 from drivers/vdpa/mlx5/net/main.c:5:
./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
   50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
      |                                                         ^~
./include/linux/mlx5/device.h:56:43: note: in expansion of macro ‘__mlx5_bit_sz’
   56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
      |                                           ^~~~~~~~~~~~~
./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
   96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
      |                              ^~~~~~~~~~~~~~~~~
./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
 1355 |  MLX5_GET(device_virtio_emulation_cap, \
      |  ^~~~~~~~
drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
   24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from <command-line>:
././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
  129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
      |                                   ^~~~~~~~~~~~~~~~~~
./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
   17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
      |                                ^~~~~~~~~~~~~~~~~~~
./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
   51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
      |                                   ^~~~~~~~
./include/linux/mlx5/device.h:56:70: note: in expansion of macro ‘__mlx5_bit_off’
   56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
      |                                                                      ^~~~~~~~~~~~~~
./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
   96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
      |                              ^~~~~~~~~~~~~~~~~
./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
 1355 |  MLX5_GET(device_virtio_emulation_cap, \
      |  ^~~~~~~~
drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
   24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/mlx5/driver.h:52,
                 from drivers/vdpa/mlx5/net/main.c:5:
./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘event_mode’
   50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
      |                                                         ^~
./include/linux/mlx5/device.h:57:47: note: in expansion of macro ‘__mlx5_bit_sz’
   57 | #define __mlx5_mask(typ, fld) ((u32)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
      |                                               ^~~~~~~~~~~~~
./include/linux/mlx5/device.h:97:1: note: in expansion of macro ‘__mlx5_mask’
   97 | __mlx5_mask(typ, fld))
      | ^~~~~~~~~~~
./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
 1355 |  MLX5_GET(device_virtio_emulation_cap, \
      |  ^~~~~~~~
drivers/vdpa/mlx5/net/main.c:24:15: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
   24 |  event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/swab.h:5,
                 from ./include/uapi/linux/byteorder/little_endian.h:13,
                 from ./include/linux/byteorder/little_endian.h:5,
                 from ./arch/x86/include/uapi/asm/byteorder.h:5,
                 from ./include/asm-generic/bitops/le.h:6,
                 from ./arch/x86/include/asm/bitops.h:395,
                 from ./include/linux/bitops.h:29,
                 from ./include/linux/kernel.h:12,
                 from ./include/linux/list.h:9,
                 from ./include/linux/module.h:12,
                 from drivers/vdpa/mlx5/net/main.c:4:
././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
  129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
      |                                   ^~~~~~~~~~~~~~~~~~
./include/uapi/linux/swab.h:115:54: note: in definition of macro ‘__swab32’
  115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
      |                                                      ^
./include/linux/byteorder/generic.h:95:21: note: in expansion of macro ‘__be32_to_cpu’
   95 | #define be32_to_cpu __be32_to_cpu
      |                     ^~~~~~~~~~~~~
./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
   17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
      |                                ^~~~~~~~~~~~~~~~~~~
./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
   51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
      |                                   ^~~~~~~~
./include/linux/mlx5/device.h:53:34: note: in expansion of macro ‘__mlx5_bit_off’
   53 | #define __mlx5_dw_off(typ, fld) (__mlx5_bit_off(typ, fld) / 32)
      |                                  ^~~~~~~~~~~~~~
./include/linux/mlx5/device.h:96:1: note: in expansion of macro ‘__mlx5_dw_off’
   96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
      | ^~~~~~~~~~~~~
./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
 1355 |  MLX5_GET(device_virtio_emulation_cap, \
      |  ^~~~~~~~
drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
   28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/mlx5/driver.h:52,
                 from drivers/vdpa/mlx5/net/main.c:5:
./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
   50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
      |                                                         ^~
./include/linux/mlx5/device.h:56:43: note: in expansion of macro ‘__mlx5_bit_sz’
   56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
      |                                           ^~~~~~~~~~~~~
./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
   96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
      |                              ^~~~~~~~~~~~~~~~~
./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
 1355 |  MLX5_GET(device_virtio_emulation_cap, \
      |  ^~~~~~~~
drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
   28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from <command-line>:
././include/linux/compiler_types.h:129:35: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
  129 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
      |                                   ^~~~~~~~~~~~~~~~~~
./include/linux/stddef.h:17:32: note: in expansion of macro ‘__compiler_offsetof’
   17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
      |                                ^~~~~~~~~~~~~~~~~~~
./include/linux/mlx5/device.h:51:35: note: in expansion of macro ‘offsetof’
   51 | #define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
      |                                   ^~~~~~~~
./include/linux/mlx5/device.h:56:70: note: in expansion of macro ‘__mlx5_bit_off’
   56 | #define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
      |                                                                      ^~~~~~~~~~~~~~
./include/linux/mlx5/device.h:96:30: note: in expansion of macro ‘__mlx5_dw_bit_off’
   96 | __mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
      |                              ^~~~~~~~~~~~~~~~~
./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
 1355 |  MLX5_GET(device_virtio_emulation_cap, \
      |  ^~~~~~~~
drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
   28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/mlx5/driver.h:52,
                 from drivers/vdpa/mlx5/net/main.c:5:
./include/linux/mlx5/device.h:50:57: error: ‘struct mlx5_ifc_device_virtio_emulation_cap_bits’ has no member named ‘eth_frame_offload_type’
   50 | #define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
      |                                                         ^~
./include/linux/mlx5/device.h:57:47: note: in expansion of macro ‘__mlx5_bit_sz’
   57 | #define __mlx5_mask(typ, fld) ((u32)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
      |                                               ^~~~~~~~~~~~~
./include/linux/mlx5/device.h:97:1: note: in expansion of macro ‘__mlx5_mask’
   97 | __mlx5_mask(typ, fld))
      | ^~~~~~~~~~~
./include/linux/mlx5/device.h:1355:2: note: in expansion of macro ‘MLX5_GET’
 1355 |  MLX5_GET(device_virtio_emulation_cap, \
      |  ^~~~~~~~
drivers/vdpa/mlx5/net/main.c:28:7: note: in expansion of macro ‘MLX5_CAP_DEV_VDPA_EMULATION’
   28 |  if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/vdpa/mlx5/net/main.c: At top level:
drivers/vdpa/mlx5/net/main.c:62:14: error: ‘MLX5_INTERFACE_PROTOCOL_VDPA’ undeclared here (not in a function); did you mean ‘MLX5_INTERFACE_PROTOCOL_ETH’?
   62 |  .protocol = MLX5_INTERFACE_PROTOCOL_VDPA,
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |              MLX5_INTERFACE_PROTOCOL_ETH
make[3]: *** [scripts/Makefile.build:281: drivers/vdpa/mlx5/net/main.o] Error 1
make[2]: *** [scripts/Makefile.build:497: drivers/vdpa/mlx5] Error 2
make[1]: *** [scripts/Makefile.build:497: drivers/vdpa] Error 2
make: *** [Makefile:1756: drivers] Error 2


I am guessing this is because of the missing dependency, right?
So what's the plan for merging this?


-- 
MST

