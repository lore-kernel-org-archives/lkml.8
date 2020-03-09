Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109D4C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE41A206DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3b1VhTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgCIBiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 21:38:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45385 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCIBiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 21:38:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id m9so23677wro.12;
        Sun, 08 Mar 2020 18:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0zWuQ4b0enFRHwEm3IOHqmQ5hoKivC2ryI49viSBt4=;
        b=S3b1VhTK9FIU6gvxk/eQG5XRXBpzHU+u929rf9rb8uR+NOtY8i+KnEmOPso4E+lcLO
         YzfovInArHjz0AbBsJYsQVvd5Qpbqpeuc9wzSx6Ab+mr26zPkrMHkVrPDocl4gp084h8
         JNed9qJ90rrJw4OY/92aNXUmlM77xIPJSoMReMbZcBLHYfLZ/ZHR9kLuScZReY6sF9QZ
         X/rCmElrls1RNZXdh1KCrXo/9FxRuxzAYnEt2Qc1AE4xARMToNQlyiRlZzNFKeymyy8p
         EUrM8vnn2S+spDwhnodC/bpqAzuoyOT9brA3Y3PZuXwGg+aOm9vR9275g8YaoaA++u8O
         uI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0zWuQ4b0enFRHwEm3IOHqmQ5hoKivC2ryI49viSBt4=;
        b=taPbbTRky24XGNe9/8MllPmuwEhCe/RJTuH7MK+3dwY7+IJoq0lcoNcAqnrkE71moT
         mXalhvAGGL8lzT6WhxLygaF4GBrUC24EBG72HCJnfSbqpULDdmiH1lP7yT2OLb8b65Ur
         Rxpuxlj2ucGPpHBgvDlGPN6mSU/4M+W6hE5btwn3MVeSvAUwK/8G6dVbGohTEyZkf1YY
         6QhceOeS00rdaAsrprBwn2F63ydpP3ESjOlaVqxAgH7J9yHsHCIk4wnACVbcAerUZ1Ez
         M/KYydnuzLdP6r9JqzidTiUiQ4yHz0t0tulDud+neP/y8N8WzF3L1d+FJdHhk8DHeQKI
         D2uA==
X-Gm-Message-State: ANhLgQ1Td3tEKr3g5etOXLkvaQnjodVBWHWH+HkWJ5KzB+lwvPuQgoqF
        8eZ0J95zwXDyel265HL3K2ABXgxfXVXYOW3Vft4=
X-Google-Smtp-Source: ADFU+vtjZ1xOs7BWaW+x2Z6JrxgfxUinlaE6JsV1nHnLRWDKlQhdMyxUzKdOFihaspqBIy7DmHJ9pqZX8e7KfZk5f5E=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr17772505wrs.370.1583717899111;
 Sun, 08 Mar 2020 18:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200304072730.9193-1-zhang.lyra@gmail.com>
In-Reply-To: <20200304072730.9193-1-zhang.lyra@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 9 Mar 2020 09:37:42 +0800
Message-ID: <CAAfSe-tWLe3BPrVk9pC7MUyJDPJFSks208xRPXO9t=uH_i3RPA@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Add clocks for Unisoc's SC9863A
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Do you have any comments on this patch-set? I hope this can be
qualified to be merged in next merge window :)

Thanks,
Chunyan

On Wed, 4 Mar 2020 at 15:28, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Add SC9863A specific clock driver and devicetree bindings for it,
> this patch add to support the new way of specifying parents
> without name strings of clocks.
>
> Also this patchset added support gate clock for pll which need to
> wait a certain time for stable after being switched on.
>
> Changes from v5:
> * Addressed comments from Rob:
> - Removed description from "clock-names" and "reg" properties;
> - Added maxItem to "reg" property.
> * Modified the descriptions for those clocks which are a child node of
>   a syscon.
>
> Changes from v4:
> * Fixed dt_binding_check warnings.
>
> Changes from v3:
> * Rebased onto v5.6-rc1.
>
> Changes from v2:
> * Addressed comments from Stephen:
> - Remove ununsed header file from sc9863a-clk.c;
> - Added comments for clocks which were marked with CLK_IGNORE_UNUSED,
>   and removed some unnecessary CLK_IGNORE_UNUSED;
> - Added error checking for sprd_clk_regmap_init().
>
> * Addressed comments from Rob:
> - Put some clocks under syscon nodes, since these clocks have the same
>   physical address base with the syscon;
> - Added clocks maxItems and listed out clock-names.
>
> * Added Rob's reviewed-by on patch 4.
>
> Changes from v1:
> * Addressed comments:
> - Removed redefine things;
> - Switched DT bindings to yaml schema;
> - Added macros for the new way of specifying clk parents;
> - Switched to use the new way of specifying clk parents;
> - Clean CLK_IGNORE_UNUSED flags for some SC9863A clocks;
> - Dropped the module alias;
> - Use device_get_match_data() instead of of_match_node();
>
> * Added Rob's Acked-by on patch 2.
>
> Chunyan Zhang (6):
>   dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC
>     specific
>   dt-bindings: clk: sprd: add bindings for sc9863a clock controller
>   clk: sprd: Add dt-bindings include file for SC9863A
>   clk: sprd: Add macros for referencing parents without strings
>   clk: sprd: support to get regmap from parent node
>   clk: sprd: add clocks support for SC9863A
>
> Xiaolong Zhang (1):
>   clk: sprd: add gate for pll clocks
>
>  .../clock/{sprd.txt => sprd,sc9860-clk.txt}   |    2 +-
>  .../bindings/clock/sprd,sc9863a-clk.yaml      |  105 +
>  drivers/clk/sprd/Kconfig                      |    8 +
>  drivers/clk/sprd/Makefile                     |    1 +
>  drivers/clk/sprd/common.c                     |   10 +-
>  drivers/clk/sprd/composite.h                  |   39 +-
>  drivers/clk/sprd/div.h                        |   20 +-
>  drivers/clk/sprd/gate.c                       |   17 +
>  drivers/clk/sprd/gate.h                       |  120 +-
>  drivers/clk/sprd/mux.h                        |   28 +-
>  drivers/clk/sprd/pll.h                        |   55 +-
>  drivers/clk/sprd/sc9863a-clk.c                | 1772 +++++++++++++++++
>  include/dt-bindings/clock/sprd,sc9863a-clk.h  |  334 ++++
>  13 files changed, 2457 insertions(+), 54 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
>  create mode 100644 drivers/clk/sprd/sc9863a-clk.c
>  create mode 100644 include/dt-bindings/clock/sprd,sc9863a-clk.h
>
> --
> 2.20.1
>
