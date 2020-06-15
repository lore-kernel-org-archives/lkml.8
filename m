Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8CCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8FD2070E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592198521;
	bh=LHA+tmbnwM8Im496GnSRSe8+1Kp5tFVwTUHmla8PZtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cOGa4fM/anGr+qqBgXgbJYXIysVrm5WyNDfYmZ1I6mIF+PCkKNlcPeT4i/yh9QvWh
	 gXE+/82TrD1eRciFOFO5VIxaf8rPHTzWWcFdHTa9fT/806x4B8QfR9pnXHppKX7OEV
	 RxrJxqK4Td+fH/5aZsEpLjYQZku2NVgcYkUQz578=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgFOFWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgFOFV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 01:21:59 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5F6206E2;
        Mon, 15 Jun 2020 05:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592198519;
        bh=LHA+tmbnwM8Im496GnSRSe8+1Kp5tFVwTUHmla8PZtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YaW9xe59UAlrllR6xuiRMvAlMx+h+SnNpUbysjAUkO2r/znBWAjFnrs5oTOplmJDE
         nYgWLmX142coKdFzMYWcmQobWB7d2OTBs4JtwIf74ygMHEi94n/Qw5sQdKdTlXFM3O
         u4hvifv/jtnLsUC40Vyum0wuZHhL0ebLfQel85d0=
Date:   Mon, 15 Jun 2020 07:21:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: cec: don't use the deprecated help tag
Message-ID: <20200615072155.28981060@coco.lan>
In-Reply-To: <d94e7bff13e8a361353360e4cdbf637bfb701bed.1592198305.git.mchehab+huawei@kernel.org>
References: <d94e7bff13e8a361353360e4cdbf637bfb701bed.1592198305.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 15 Jun 2020 07:18:33 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> According with changeset 3e1ad4054b8d ("doc: don't use deprecated "---help---" markers in target docs"),
> We want to get rid of the old ---help--- tag.
> 
> There's just the cec/Kconfig file under drivers/media using it.
> Replace it.

Just ignore it. A treewide patch already changed it:

	a7f7f6248d97 ("treewide: replace '---help---' in Kconfig files with 'help'")

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/staging/media/atomisp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
> index f75765cb0fc8..fea06cb0eb48 100644
> --- a/drivers/staging/media/atomisp/Kconfig
> +++ b/drivers/staging/media/atomisp/Kconfig
> @@ -15,7 +15,7 @@ config VIDEO_ATOMISP
>  	depends on PMIC_OPREGION
>  	select IOSF_MBI
>  	select VIDEOBUF_VMALLOC
> -	---help---
> +	help
>  	  Say Y here if your platform supports Intel Atom SoC
>  	  camera imaging subsystem.
>  	  To compile this driver as a module, choose M here: the



Thanks,
Mauro
