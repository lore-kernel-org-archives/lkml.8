Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B70C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794B32063A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgDYMun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:50:43 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:33678 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726062AbgDYMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 08:50:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C2D8A182CED2A;
        Sat, 25 Apr 2020 12:50:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: size64_5e7406f83605
X-Filterd-Recvd-Size: 4382
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 25 Apr 2020 12:50:40 +0000 (UTC)
Message-ID: <b5aa72347748f35245f2fd0272ab3957179ed2eb.camel@perches.com>
Subject: Re: [PATCH 1/3] staging: vt6656: Remove the local variable "array"
From:   Joe Perches <joe@perches.com>
To:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 25 Apr 2020 05:50:39 -0700
In-Reply-To: <20200425123844.7959-2-oscar.carter@gmx.com>
References: <20200425123844.7959-1-oscar.carter@gmx.com>
         <20200425123844.7959-2-oscar.carter@gmx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-25 at 14:38 +0200, Oscar Carter wrote:
> Remove the local variable "array" and all the memcpy function calls
> because this copy operation from different arrays to this variable is
> unnecessary.

You might write here that vnt_control_out already does
a kmemdup copy of its const char *buffer argument and
this was made unnecessary by:

commit 12ecd24ef93277e4e5feaf27b0b18f2d3828bc5e
Author: Malcolm Priestley <tvboxspy@gmail.com>
Date:   Sat Apr 22 11:14:57 2017 +0100

    staging: vt6656: use off stack for out buffer USB transfers.
    
    Since 4.9 mandated USB buffers be heap allocated this causes the driver
    to fail.
    
    Since there is a wide range of buffer sizes use kmemdup to create
    allocated buffer.
 

> The same result can be achieved using the arrays directly.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/rf.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
> index 06fa8867cfa3..82d3b6081b5b 100644
> --- a/drivers/staging/vt6656/rf.c
> +++ b/drivers/staging/vt6656/rf.c
> @@ -770,7 +770,6 @@ int vnt_rf_table_download(struct vnt_private *priv)
>  	u16 length1 = 0, length2 = 0, length3 = 0;
>  	u8 *addr1 = NULL, *addr2 = NULL, *addr3 = NULL;
>  	u16 length, value;
> -	u8 array[256];
> 
>  	switch (priv->rf_type) {
>  	case RF_AL2230:
> @@ -817,10 +816,8 @@ int vnt_rf_table_download(struct vnt_private *priv)
>  	}
> 
>  	/* Init Table */
> -	memcpy(array, addr1, length1);
> -
>  	ret = vnt_control_out(priv, MESSAGE_TYPE_WRITE, 0,
> -			      MESSAGE_REQUEST_RF_INIT, length1, array);
> +			      MESSAGE_REQUEST_RF_INIT, length1, addr1);
>  	if (ret)
>  		goto end;
> 
> @@ -832,10 +829,8 @@ int vnt_rf_table_download(struct vnt_private *priv)
>  		else
>  			length = length2;
> 
> -		memcpy(array, addr2, length);
> -
>  		ret = vnt_control_out(priv, MESSAGE_TYPE_WRITE, value,
> -				      MESSAGE_REQUEST_RF_CH0, length, array);
> +				      MESSAGE_REQUEST_RF_CH0, length, addr2);
>  		if (ret)
>  			goto end;
> 
> @@ -852,10 +847,8 @@ int vnt_rf_table_download(struct vnt_private *priv)
>  		else
>  			length = length3;
> 
> -		memcpy(array, addr3, length);
> -
>  		ret = vnt_control_out(priv, MESSAGE_TYPE_WRITE, value,
> -				      MESSAGE_REQUEST_RF_CH1, length, array);
> +				      MESSAGE_REQUEST_RF_CH1, length, addr3);
>  		if (ret)
>  			goto end;
> 
> @@ -870,11 +863,9 @@ int vnt_rf_table_download(struct vnt_private *priv)
>  		addr1 = &al7230_init_table_amode[0][0];
>  		addr2 = &al7230_channel_table2[0][0];
> 
> -		memcpy(array, addr1, length1);
> -
>  		/* Init Table 2 */
>  		ret = vnt_control_out(priv, MESSAGE_TYPE_WRITE, 0,
> -				      MESSAGE_REQUEST_RF_INIT2, length1, array);
> +				      MESSAGE_REQUEST_RF_INIT2, length1, addr1);
>  		if (ret)
>  			goto end;
> 
> @@ -886,11 +877,9 @@ int vnt_rf_table_download(struct vnt_private *priv)
>  			else
>  				length = length2;
> 
> -			memcpy(array, addr2, length);
> -
>  			ret = vnt_control_out(priv, MESSAGE_TYPE_WRITE, value,
>  					      MESSAGE_REQUEST_RF_CH2, length,
> -					      array);
> +					      addr2);
>  			if (ret)
>  				goto end;
> 
> --
> 2.20.1
> 

