Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0778C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9025B20674
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqPmldYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgGFWEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:04:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40848 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726134AbgGFWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594073087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSaKePDZle72IIsbb8OTU+Jf3IEEa87RrzjMduxWjDA=;
        b=NqPmldYz8UUG7uoK/ROx6z54IKlGLZuf93fQ2eyslTBg9+nGBykJa08ZMCkeLRDlqmyYFw
        1luFgCmpRmcQmWrdj9oKP1mGk4rcujCfmOCOACyU8GRSTUl5vC5Lsudf2Z2nPBnKVrYxRj
        UWGrlLyfSv2LV7Nt0HHe+kUSASkxY98=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-kPWDvyu7P2uFavuMSBCC5w-1; Mon, 06 Jul 2020 18:04:43 -0400
X-MC-Unique: kPWDvyu7P2uFavuMSBCC5w-1
Received: by mail-qt1-f200.google.com with SMTP id y5so29222628qto.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 15:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=MSaKePDZle72IIsbb8OTU+Jf3IEEa87RrzjMduxWjDA=;
        b=sKifNJ87913hsMdaj/cNXlcEjviaHqiNgGkxLOirodDu24rz3a+7KqbeDia9i7Lfu+
         kOYO/5sWvWhj0Yvl3YkW82kHF2rLTPXPdlFZ3XYWkFsEkoI+OLzst785rXpdZ+bucn2q
         X7qaLOTewJNtlfbhG1m9OuITLqqHXpjJt20Xa6Nsj21peC6ombsg+BvirKxMisGHBbOu
         WbzJ83NtbKRtZR+susf3I54omZDwWPf/C4plP8a3fMnkguejPj1HDqSyNrPCxIwjhkKY
         6qv1VcsV4CUCCWzjwpXxmKzIlor5LEW+KWdYmVC7TSe+ijiwueQNHIuQ5aHbf1x7srLy
         Wbzg==
X-Gm-Message-State: AOAM531f5jocHZAf3reHmmKyDn2Ep914UIflD/JvFw6OWVGZj719rBtn
        C6ikzHup8rXmjzvs4SWV6RLFAJKBndFfNh1hU+VHqho2pG0Fwh6BWpeEHKOGQW9dcLbnZFOTWgo
        jLDD439TMU99JkUbKOwvOKrR4
X-Received: by 2002:ac8:1654:: with SMTP id x20mr37876343qtk.83.1594073082947;
        Mon, 06 Jul 2020 15:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvOU43xLsFZyXwqGMfGhqw/yW2xje7LPDpb4qxzz0sU5xjanrS4P3Dk5VdzPvK36hOokI7wg==
X-Received: by 2002:ac8:1654:: with SMTP id x20mr37876323qtk.83.1594073082687;
        Mon, 06 Jul 2020 15:04:42 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l202sm20315146qke.109.2020.07.06.15.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 15:04:42 -0700 (PDT)
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com> <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in TPM2 ACPI table
In-reply-to: <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
Date:   Mon, 06 Jul 2020 15:04:40 -0700
Message-ID: <87eepowb9j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stefan Berger @ 2020-07-06 11:19 MST:

> From: Stefan Berger <stefanb@linux.ibm.com>
>
> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
> to get the event log from ACPI. If one is found, use it to get the
> start and length of the log area. This allows non-UEFI systems, such
> as SeaBIOS, to pass an event log when using a TPM2.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/eventlog/acpi.c | 63 +++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 63ada5e53f13..3633ed70f48f 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -49,9 +49,9 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	void __iomem *virt;
>  	u64 len, start;
>  	struct tpm_bios_log *log;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return -ENODEV;
> +	struct acpi_table_tpm2 *tbl;
> +	struct acpi_tpm2_phy *tpm2_phy;
> +	int format;
>  
>  	log = &chip->log;
>  
> @@ -61,23 +61,44 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	if (!chip->acpi_dev_handle)
>  		return -ENODEV;
>  
> -	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> -	status = acpi_get_table(ACPI_SIG_TCPA, 1,
> -				(struct acpi_table_header **)&buff);
> -
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> -
> -	switch(buff->platform_class) {
> -	case BIOS_SERVER:
> -		len = buff->server.log_max_len;
> -		start = buff->server.log_start_addr;
> -		break;
> -	case BIOS_CLIENT:
> -	default:
> -		len = buff->client.log_max_len;
> -		start = buff->client.log_start_addr;
> -		break;
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		status = acpi_get_table("TPM2", 1,
> +					(struct acpi_table_header **)&tbl);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +
> +		if (tbl->header.length <
> +				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy))
> +			return -ENODEV;
> +
> +		tpm2_phy = (void *)tbl + sizeof(*tbl);
> +		len = tpm2_phy->log_area_minimum_length;
> +
> +		start = tpm2_phy->log_area_start_address;
> +		if (!start || !len)
> +			return -ENODEV;
> +
> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> +	} else {
> +		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
> +		status = acpi_get_table(ACPI_SIG_TCPA, 1,
> +					(struct acpi_table_header **)&buff);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +
> +		switch (buff->platform_class) {
> +		case BIOS_SERVER:
> +			len = buff->server.log_max_len;
> +			start = buff->server.log_start_addr;
> +			break;
> +		case BIOS_CLIENT:
> +		default:
> +			len = buff->client.log_max_len;
> +			start = buff->client.log_start_addr;
> +			break;
> +		}
> +
> +		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>  	}
>  	if (!len) {
>  		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
> @@ -98,7 +119,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	memcpy_fromio(log->bios_event_log, virt, len);
>  
>  	acpi_os_unmap_iomem(virt, len);
> -	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +	return format;
>  
>  err:
>  	kfree(log->bios_event_log);

