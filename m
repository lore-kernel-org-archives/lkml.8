Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F90DC3524B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 11:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F522080D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 11:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580641671;
	bh=qa1ivRHlfNgMIUlZq4FIKXe33eZU8vPPT92vwKWxYWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IAtuR/EMAiDwqAsqDkfvaHSp2lcGGU/f8nSMWZ+epBqffAlaJQdI9xDJia7/ihL89
	 gguaoEZ54zbCKXdN6L9KlcZthsPCClGb5AkSvsMyUVrabDJKIEKxwMwtEEYqEEGps4
	 TUdofCtk1pBG4sni9e1XYTmJqW0a6ec/ug3/rROQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBBLHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 06:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgBBLHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 06:07:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CC620679;
        Sun,  2 Feb 2020 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580641670;
        bh=qa1ivRHlfNgMIUlZq4FIKXe33eZU8vPPT92vwKWxYWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KfcYjl5SlLQVjLm/vKxqWvD975Sdbh91AjA4F+X82cZ1XbWUYk4No2TJYJXNygomh
         QYEeZOwKSBZN/lY1LHTSFS/CnJK8LY34dBJhKiH7NBJDBpAhFTbEw+vAnSAcZIN4l4
         ajnt3rxEm9z0HIRrbK6U73LHmZlHHZoxFjKU1n1Q=
Date:   Sun, 2 Feb 2020 11:07:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     JieunKim <jieun.kim4758@gmail.com>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix mismatched comments
Message-ID: <20200202110745.1d16533e@archlinux>
In-Reply-To: <20200127120359.3955-1-jieun.kim4758@gmail.com>
References: <20200127120359.3955-1-jieun.kim4758@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 21:03:59 +0900
JieunKim <jieun.kim4758@gmail.com> wrote:

> odr to odr_table
> gain to fs_table
> 
> 'gain' is actually in 'st_lsm6dsx_fs' structure of 'fs_table'
> 
> Signed-off-by: JieunKim <jieun.kim4758@gmail.com>
Applied.  Thanks.

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 9c3486a8134f..f2113a63721a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -230,8 +230,8 @@ enum st_lsm6dsx_ext_sensor_id {
>   * @i2c_addr: I2c slave address list.
>   * @wai: Wai address info.
>   * @id: external sensor id.
> - * @odr: Output data rate of the sensor [Hz].
> - * @gain: Configured sensor sensitivity.
> + * @odr_table: Output data rate of the sensor [Hz].
> + * @fs_table: Configured sensor sensitivity table depending on full scale.
>   * @temp_comp: Temperature compensation register info (addr + mask).
>   * @pwr_table: Power on register info (addr + mask).
>   * @off_canc: Offset cancellation register info (addr + mask).

