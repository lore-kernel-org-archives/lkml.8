Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B224E2076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGB2C7ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgHCOnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgHCOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:43:06 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B187C06174A;
        Mon,  3 Aug 2020 07:43:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b22so7494820oic.8;
        Mon, 03 Aug 2020 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlJ/pfmkJqMXK+j8msF9RyBAJEzwd8det+Lucq2VVo8=;
        b=hGB2C7ty6ES3zSVyXgGeGFkqbvL2Hx1gVURFpyocYcNmCI3+k44ab9oR6RTbKwx4Lz
         464iIE/54PPQC8n8TfZTvFjqTO/oDOEdXvyUdT3/T8SzHZuh7HaYwjHSe6WneC1G511s
         2uFKSdaxVLlAO0d4f2PoKOjWhjleFN3KqEtpnHHy+iPoS8LD6Cg8deQ9IgB61d0qN8WA
         7E4Ju9e/8pESpOVQJ+N5+g4DDsvob/BFxRC96NkaF+lIq2J/Vl0oWuUq5qXJdewjlT5z
         VTDdFIsRXVenkFf5Pgp/vF6JIlB/3jpwR+ouhmWvPHWwlQS3n4jHzp8SIY7q4aSDSiS7
         GmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlJ/pfmkJqMXK+j8msF9RyBAJEzwd8det+Lucq2VVo8=;
        b=JV43rs5knKVrQhPrjQKcG+KPpRu1cqrzqCvzgUCrPoqd1yy4nKqa/UkZtG5+LqBRKZ
         zt4gNCxN/bwognwQqqApYotzJ/D9OxbHJyOLkFuvioG7XYS9trzO9ACRFClaPTII7VFe
         7C5biP0cF2a+Y7yIBsQh4NsD8NOcCdyHYLIBomHrKPGHVftwRWbBdRqhYHG78btRjEpw
         PiGHA7csn31JKPyeLV2uOmks6vEruPusCAxFK/8sI/7uFikGaOGW8/fGWggmSJ2qAv3H
         fCCnkeET0sDnhjphch/Had0ZrK7LScE6l0HR59CIesp9BJ29kjXrTkVBuxOW6HUWKtsn
         Kcgg==
X-Gm-Message-State: AOAM530w3QSZ1gV3/MYvKyEnso3ctoZBIOXOQ0Yx49pbtAr221ngfU4N
        13zJhEl7lOgJn5TF3cxxfN+O+jTmPiYHOBImX6k=
X-Google-Smtp-Source: ABdhPJw7dcbZ+tupvYShtZ8DuiVRT6dfJ2foCBZwntEo/a4is2r+4S6ARBjSgKQ2hmEiArQzvvOUMvPqMSQTqGRtcI8=
X-Received: by 2002:aca:5bc6:: with SMTP id p189mr12438996oib.130.1596465785793;
 Mon, 03 Aug 2020 07:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200803143636.GD346925@mwanda>
In-Reply-To: <20200803143636.GD346925@mwanda>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 3 Aug 2020 17:41:06 +0300
Message-ID: <CAFCwf13LgaFGeg7NSOL6KqMuFoPovbezdCUSjk3S05ZSm=48mA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Fix memory corruption in debugfs
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Mike Rapoport <rppt@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 5:36 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This has to be a long instead of a u32 because we write a long value.
> On 64 bit systems, this will cause memory corruption.
>
> Fixes: c216477363a3 ("habanalabs: add debugfs support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/habanalabs/common/debugfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
> index 71cfe1b6fafc..ecd37b427480 100644
> --- a/drivers/misc/habanalabs/common/debugfs.c
> +++ b/drivers/misc/habanalabs/common/debugfs.c
> @@ -19,7 +19,7 @@
>  static struct dentry *hl_debug_root;
>
>  static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
> -                               u8 i2c_reg, u32 *val)
> +                               u8 i2c_reg, long *val)
>  {
>         struct armcp_packet pkt;
>         int rc;
> @@ -36,7 +36,7 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
>         pkt.i2c_reg = i2c_reg;
>
>         rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
> -                                               0, (long *) val);
> +                                               0, val);
>
>         if (rc)
>                 dev_err(hdev->dev, "Failed to read from I2C, error %d\n", rc);
> @@ -827,7 +827,7 @@ static ssize_t hl_i2c_data_read(struct file *f, char __user *buf,
>         struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
>         struct hl_device *hdev = entry->hdev;
>         char tmp_buf[32];
> -       u32 val;
> +       long val;
>         ssize_t rc;
>
>         if (*ppos)
> @@ -842,7 +842,7 @@ static ssize_t hl_i2c_data_read(struct file *f, char __user *buf,
>                 return rc;
>         }
>
> -       sprintf(tmp_buf, "0x%02x\n", val);
> +       sprintf(tmp_buf, "0x%02lx\n", val);
>         rc = simple_read_from_buffer(buf, count, ppos, tmp_buf,
>                         strlen(tmp_buf));
>
> --
> 2.27.0
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>

Applied to -fixes,
Thanks!
Oded
