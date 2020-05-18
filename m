Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE9EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A9320657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXCvPlbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgERSdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgERSc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:32:59 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A17C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:32:58 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p4so5200399qvr.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6hi1rrNtPKGurqtuvzRNaOED97sTicPfJzHu8wjv0A=;
        b=VXCvPlbewLRnjk+XCmKk3io0FDq/mVREC5+z/CS1b6F/6F5Vald7FO8ZUSxj09yygY
         wSM7JWf0IDyDq7NVBUbJqbV3oj9pLTvqBdoyUaL/TizOEXGoSoUU7i3q96JR+FBSr7UT
         Wi6aZCZb9Z6J7QM3TK++xp8jHhjDRNBiEZ4C36RBvCrQi5dB24g7q8JjDzCK25Fg52Vo
         ReG29DQ0RmBv7D4kd7FgQqTPs+Ow0htCs+M8X9AUhnUIvjmwV+QFBO+CRVDSwp76wnA8
         8B3laXVWE72oh4gGeGYcp19PPiksrKbiFsFXs6Zx+0aQMRZ3a0oXJu1ezlHcnuSyfm3j
         Vuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6hi1rrNtPKGurqtuvzRNaOED97sTicPfJzHu8wjv0A=;
        b=AbY04YgoLXxHoJ7idYmnC2JbAbmihURc4Jo1xkZAMgr8K6ZNljO2AZFQ3RlJ3m0zDG
         Ua3qRd6ok/rFO8AlI+jrZovqY0YOFpaZATsTtwxSPhRavcestktSqhu51iZVuTpdNFo2
         t5al2uNgEdhTFoO7knR2JwaSXxagqdyPDqCIVOk+oncmwX3QXcgpF+xTSxDiI2GcX3jL
         8i1f2nNFdAMjOHARl1IYmIEoJ9BnSbUOvaqg09JX1N/7QO0vfngwoZga0jPULad1vKmb
         BHqcoprbxtXQAXi28ISxz/d51efcJyDwpixYn3BmRwYeixS5VbUmvwRsDOFwI5nMUKl4
         m+4g==
X-Gm-Message-State: AOAM533wee6VVCnpymdFPcGDdpqW/DIkAEi01/bnJZ0yz3hP1juWYozw
        Q2ydW1sps0zpY3uauVVSU6MgZCuBQ9q24Cz6uKo=
X-Google-Smtp-Source: ABdhPJyqxvmh9rJ31Mq/U5nvKnfwPluC1R2wT2iMF4O6fKI1BM5ejNKhZVf2iLmi66MdIYovUz+3S9wSdI8GxSOWGco=
X-Received: by 2002:ad4:4145:: with SMTP id z5mr17353001qvp.29.1589826777307;
 Mon, 18 May 2020 11:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200518135943.11749-1-huobean@gmail.com> <20200518135943.11749-6-huobean@gmail.com>
In-Reply-To: <20200518135943.11749-6-huobean@gmail.com>
From:   Steve deRosier <derosier@gmail.com>
Date:   Mon, 18 May 2020 11:32:21 -0700
Message-ID: <CALLGbR+MWz82hcC6jrv+MrH6Rhj5McW5vt9V+x4UhiZdsoqkRg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] mtd: rawnand: micron: Micron SLC NAND filling block
To:     Bean Huo <huobean@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, s.hauer@pengutronix.de,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 7:00 AM Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> On some legacy planar 2D Micron NAND devices when a block erase command

I object the use of the qualifications you're putting in this
sentence. By saying "some legacy...." you're implying that there's a
set that does and a set that doesn't require this. Which then leads
the reader of this commit message to #1 look for which ones this
applies to vs not, and #2 want to remove/exclude the feature when
they're using a "current" device. The wiggle-word wording is confusing
and dishonest.

I've followed this discussion now intently and it seems like Micron is
either unable or unwilling to determine which specific devices this
does or doesn't apply to. If you are unable to identify and restrict
this functionality to a specific subset of devices, then the fact is
it's "all."  Let's just say that and eliminate the confusion. And
please also update your datasheets to indicate that this is the
correct algorithm for working with these devices. Better would be to
issue an errata on the chips and notify your customers. I feel for
those customers who aren't using Linux and don't know the reliability
problem they've been tracking down for the last couple of years is
already known but they don't have any way of knowing about it.

In your commit message, rewording to "On planar 2D Micron NAND devices
when a block erase command..." is sufficient.

- Steve


> is issued, occasionally even though a block erase operation completes and
> returns a pass status, the flash block may not be completely erased.
> Subsequent operations to this block on very rare cases can result in subtle
> failures or corruption. These extremely rare cases should nevertheless be
> considered. These rare occurrences have been observed on partially written
> blocks.
>
> To avoid this rare occurrence, we should make sure that at least 15 pages
> have been programmed to a block before it is erased. In case we find that
> less than 15 pages have been programmed, we will rewrite first 15 pages of
> block.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/mtd/nand/raw/nand_micron.c | 102 +++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index b3485b0995ad..c5fd9e60f46d 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -36,6 +36,9 @@
>  #define NAND_ECC_STATUS_1_3_CORRECTED  BIT(4)
>  #define NAND_ECC_STATUS_7_8_CORRECTED  (BIT(4) | BIT(3))
>
> +#define MICRON_SHALLOW_ERASE_MIN_PAGE 15
> +#define MICRON_PAGE_MASK_TRIGGER GENMASK(MICRON_SHALLOW_ERASE_MIN_PAGE, 0)
> +
>  struct nand_onfi_vendor_micron {
>         u8 two_plane_read;
>         u8 read_cache;
> @@ -64,6 +67,7 @@ struct micron_on_die_ecc {
>
>  struct micron_nand {
>         struct micron_on_die_ecc ecc;
> +       u16 *writtenp;
>  };
>
>  static int micron_nand_setup_read_retry(struct nand_chip *chip, int retry_mode)
> @@ -429,6 +433,93 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
>         return MICRON_ON_DIE_SUPPORTED;
>  }
>
> +static int micron_nand_pre_erase(struct nand_chip *chip, u32 eraseblock)
> +{
> +       struct micron_nand *micron = nand_get_manufacturer_data(chip);
> +       struct mtd_info *mtd = nand_to_mtd(chip);
> +       u8 last_page = MICRON_SHALLOW_ERASE_MIN_PAGE - 1;
> +       u32 page;
> +       u8 *data_buf;
> +       int ret, i;
> +
> +       data_buf = nand_get_data_buf(chip);
> +       WARN_ON(!data_buf);
> +
> +       if (likely(micron->writtenp[eraseblock] & BIT(last_page)))
> +               return 0;
> +
> +       page = eraseblock << (chip->phys_erase_shift - chip->page_shift);
> +
> +       if (unlikely(micron->writtenp[eraseblock] == 0)) {
> +               ret = nand_read_page_raw(chip, data_buf, 1, page + last_page);
> +               if (ret)
> +                       return ret; /* Read error */
> +               ret = nand_check_is_erased_page(chip, data_buf, true);
> +               if (!ret)
> +                       return 0;
> +       }
> +
> +       memset(data_buf, 0x00, mtd->writesize);
> +
> +       for (i = 0; i < MICRON_SHALLOW_ERASE_MIN_PAGE; i++) {
> +               ret = nand_write_page_raw(chip, data_buf, false, page + i);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int micron_nand_post_erase(struct nand_chip *chip, u32 eraseblock)
> +{
> +       struct micron_nand *micron = nand_get_manufacturer_data(chip);
> +
> +       if (!micron)
> +               return -EINVAL;
> +
> +       micron->writtenp[eraseblock] = 0;
> +
> +       return 0;
> +}
> +
> +static int micron_nand_write_oob(struct nand_chip *chip, loff_t to,
> +                                struct mtd_oob_ops *ops)
> +{
> +       struct micron_nand *micron = nand_get_manufacturer_data(chip);
> +       u32 eb_sz = nanddev_eraseblock_size(&chip->base);
> +       u32 p_sz = nanddev_page_size(&chip->base);
> +       u32 ppeb = nanddev_pages_per_eraseblock(&chip->base);
> +       u32 nb_p_tot = ops->len / p_sz;
> +       u32 first_eb = DIV_ROUND_DOWN_ULL(to, eb_sz);
> +       u32 first_p = DIV_ROUND_UP_ULL(to - (first_eb * eb_sz), p_sz);
> +       u32 nb_eb = DIV_ROUND_UP_ULL(first_p + nb_p_tot, ppeb);
> +       u32 remaining_p, eb, nb_p;
> +       int ret;
> +
> +       ret = nand_write_oob_nand(chip, to, ops);
> +
> +       if (ret || ops->len != ops->retlen)
> +               return ret;
> +
> +       /* Mark the last pages of the first erase block to write */
> +       nb_p = min(nb_p_tot, ppeb - first_p);
> +       micron->writtenp[first_eb] |= GENMASK(first_p + nb_p, 0) &
> +                                       MICRON_PAGE_MASK_TRIGGER;
> +       remaining_p = nb_p_tot - nb_p;
> +
> +       /* Mark all the pages of all "in-the-middle" erase blocks */
> +       for (eb = first_eb + 1; eb < first_eb + nb_eb - 1; eb++) {
> +               micron->writtenp[eb] |= MICRON_PAGE_MASK_TRIGGER;
> +               remaining_p -= ppeb;
> +       }
> +
> +       /* Mark the first pages of the last erase block to write */
> +       if (remaining_p)
> +               micron->writtenp[eb] |= GENMASK(remaining_p - 1, 0) &
> +                                       MICRON_PAGE_MASK_TRIGGER;
> +               return 0;
> +}
> +
>  static int micron_nand_init(struct nand_chip *chip)
>  {
>         struct mtd_info *mtd = nand_to_mtd(chip);
> @@ -515,6 +606,17 @@ static int micron_nand_init(struct nand_chip *chip)
>                 }
>         }
>
> +       if (nand_is_slc(chip)) {
> +               micron->writtenp = kcalloc(nanddev_neraseblocks(&chip->base),
> +                                          sizeof(u16), GFP_KERNEL);
> +               if (!micron->writtenp)
> +                       goto err_free_manuf_data;
> +
> +               chip->ops.write_oob = micron_nand_write_oob;
> +               chip->ops.pre_erase = micron_nand_pre_erase;
> +               chip->ops.post_erase = micron_nand_post_erase;
> +       }
> +
>         return 0;
>
>  err_free_manuf_data:
> --
> 2.17.1
>
