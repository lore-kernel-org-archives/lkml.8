Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415CAC33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10967214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 18:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imz0Dk/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbgALSWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 13:22:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36259 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbgALSWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 13:22:03 -0500
Received: by mail-qt1-f194.google.com with SMTP id i13so7172171qtr.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pykkr3F66k7d7FVxfuvlxLW7YZg4/2EqKAq/W06OIdQ=;
        b=Imz0Dk/xVUbz1ODH7orlJWunNhmZ3/M5FvVyYYmtXFoorYCuAvnJhuZIx5i775wwjR
         zHrrOHgH6pltrG+f8KdWMvwp4ne30QQiNe9GcpwZM0+NmfDiiuY8Axn8RihQVAqSwmH/
         BWPjk4Y+Lxk59rQonUkw+uy2AiNAcjmCDHUn7GVeJN6NpMH/JRMuv8BXWigTRxiHE7Pa
         cynNMzqlu1WTUnMb1h42xnPnw/yw9nzxxWhTSL9TSI2CoF4EHW3F0uX18a4Zq5886Izx
         XQ+p3sO8sRRPyubDIElonrLx2isnLC9KfEFKCw3Ueh395NKfrcCyelgUGUDH1cq+T+TJ
         3aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Pykkr3F66k7d7FVxfuvlxLW7YZg4/2EqKAq/W06OIdQ=;
        b=np7eYmXxGxo/4j6sAafhc7/qDHvc2NKvZSuHfhg8/3NU2mV+VY23ekfu8NRnIiZVNN
         PbP/6+iPykwfS02P4nM8WZOlVcUwrjd5wSZNoyO+KVPFYnyalPMIUj0aa8yMfEo0pmQo
         RC2cfa16+WC+EbzkJtxHX0XwVaw++t4HLngasO/M8/rtin6twGkQcwh/b83PcrCqLBQG
         p6crEakwpExYEzyDTTYfJYvLy+YqNrsYnfzUD0GnmywQmrceVDk49DQb2GDPp3DD+Nwz
         rcSyS+9zxN7bNJfbR9lau8IN+HRqS+cCIzPxAO7XpYrPi9KFH0IWnu2ehmcMXYu7ZZq+
         Qzrw==
X-Gm-Message-State: APjAAAVZgcB7YHIzZJjJIbabvc7l8H9sBXP2HzGZPxzkV+VnukbjhQLU
        hdTbQVJhUNfev2fGIVhErQs=
X-Google-Smtp-Source: APXvYqwV8zszJaNPB5Mzahgr+LxbH9mxiEcfFhjHDktrcHg2qQTiZPIAGbKvi34j17tJCULrNJnEng==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr10896100qtq.371.1578853322791;
        Sun, 12 Jan 2020 10:22:02 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id h8sm4361679qtm.51.2020.01.12.10.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 10:22:02 -0800 (PST)
Date:   Sun, 12 Jan 2020 13:22:00 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Peter Jones <pjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] iscsi_ibft: Don't limits Targets and NICs to two
Message-ID: <20200112182200.GA11668@localhost.localdomain>
References: <20191221070956.268321-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221070956.268321-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2019 at 08:09:56AM +0100, Lubomir Rintel wrote:
> According to iSCSI Boot Firmware Table Version 1.03 [1], the length of
> the control table is ">= 18", where the optional expansion structure
> pointer follow the mandatory ones. This allows for more than two NICs
> and Targets.
> 
> [1] ftp://ftp.software.ibm.com/systems/support/bladecenter/iscsi_boot_firmware_table_v1.03.pdf
> 
> Let's enforce the minimum length of the control structure instead
> instead of limiting it to the smallest allowed size.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Put it in my tree and will send it up to Linus for the next merge
window.

Thanks!
> ---
>  drivers/firmware/iscsi_ibft.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> index 7e12cbdf957cc..96758b71a8db8 100644
> --- a/drivers/firmware/iscsi_ibft.c
> +++ b/drivers/firmware/iscsi_ibft.c
> @@ -104,6 +104,7 @@ struct ibft_control {
>  	u16 tgt0_off;
>  	u16 nic1_off;
>  	u16 tgt1_off;
> +	u16 expansion[0];
>  } __attribute__((__packed__));
>  
>  struct ibft_initiator {
> @@ -235,7 +236,7 @@ static int ibft_verify_hdr(char *t, struct ibft_hdr *hdr, int id, int length)
>  				"found %d instead!\n", t, id, hdr->id);
>  		return -ENODEV;
>  	}
> -	if (hdr->length != length) {
> +	if (length && hdr->length != length) {
>  		printk(KERN_ERR "iBFT error: We expected the %s " \
>  				"field header.length to have %d but " \
>  				"found %d instead!\n", t, length, hdr->length);
> @@ -749,16 +750,16 @@ static int __init ibft_register_kobjects(struct acpi_table_ibft *header)
>  	control = (void *)header + sizeof(*header);
>  	end = (void *)control + control->hdr.length;
>  	eot_offset = (void *)header + header->header.length - (void *)control;
> -	rc = ibft_verify_hdr("control", (struct ibft_hdr *)control, id_control,
> -			     sizeof(*control));
> +	rc = ibft_verify_hdr("control", (struct ibft_hdr *)control, id_control, 0);
>  
>  	/* iBFT table safety checking */
>  	rc |= ((control->hdr.index) ? -ENODEV : 0);
> +	rc |= ((control->hdr.length < sizeof(*control)) ? -ENODEV : 0);
>  	if (rc) {
>  		printk(KERN_ERR "iBFT error: Control header is invalid!\n");
>  		return rc;
>  	}
> -	for (ptr = &control->initiator_off; ptr < end; ptr += sizeof(u16)) {
> +	for (ptr = &control->initiator_off; ptr + sizeof(u16) <= end; ptr += sizeof(u16)) {
>  		offset = *(u16 *)ptr;
>  		if (offset && offset < header->header.length &&
>  						offset < eot_offset) {
> -- 
> 2.24.1
> 
