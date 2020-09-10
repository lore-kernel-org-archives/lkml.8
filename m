Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CA1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972CC2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599726842;
	bh=+uYj31dIE6aLQLGtOUfoRlwyftNHQyhq7bqNm1EFOzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rplGf6Tnu0D6UNc90xEekR+0BolapqbI9kx3vtz1WZ6DvbyWKsGSMK+MheQ+uBH8n
	 tCRyxBAIkXRoAzjUbcQO/4aQKS3xx1QJiohdKq4RCHMYQtCdmeOvir8kjqxfLfgWjn
	 D/sffZiR2ycZ0PAINF9aEY0gmCLi9F61A8GqBAWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgIJIeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgIJIUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:20:35 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9878720732;
        Thu, 10 Sep 2020 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599726002;
        bh=+uYj31dIE6aLQLGtOUfoRlwyftNHQyhq7bqNm1EFOzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMedj2nqh7AnwsubKUx2cDGygfPeMZ/DC22/dIFpecBdxjizUINcIlzCJEoaIbbIN
         UWw0szHE23w4EXoWTQS5bdHpXZJn+r4Qn69vCnYUsWm6z4fAaxGT/Xg3uOtH4R0Mwv
         MHIGn/OTGcDdKwWYo8ufZTdtJgupVMoBGdzsB9ys=
Received: by pali.im (Postfix)
        id 736C6582; Thu, 10 Sep 2020 10:20:00 +0200 (CEST)
Date:   Thu, 10 Sep 2020 10:20:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, chromeos-bluetooth-upstreaming@chromium.org,
        josephsih@google.com, Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Bluetooth: sco: new getsockopt options
 BT_SNDMTU/BT_RCVMTU
Message-ID: <20200910082000.aiw74ll3z776yqgh@pali>
References: <20200910060403.144524-1-josephsih@chromium.org>
 <20200910140342.v3.2.I03247d3813c6dcbcdbeab26d068f9fd765edb1f5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200910140342.v3.2.I03247d3813c6dcbcdbeab26d068f9fd765edb1f5@changeid>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 September 2020 14:04:02 Joseph Hwang wrote:
> This patch defines new getsockopt options BT_SNDMTU/BT_RCVMTU
> for SCO socket to be compatible with other bluetooth sockets.
> These new options return the same value as option SCO_OPTIONS
> which is already present on existing kernels.
> 
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>

Looks good,

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
> 
> Changes in v3:
> - Fixed the commit message.
> 
> Changes in v2:
> - Used BT_SNDMTU/BT_RCVMTU instead of creating a new opt name.
> - Used the existing conn->mtu instead of creating a new member
>   in struct sco_pinfo.
> - Noted that the old SCO_OPTIONS in sco_sock_getsockopt_old()
>   would just work as it uses sco_pi(sk)->conn->mtu.
> 
>  net/bluetooth/sco.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index dcf7f96ff417e6..79ffcdef0b7ad5 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1001,6 +1001,12 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>  			err = -EFAULT;
>  		break;
>  
> +	case BT_SNDMTU:
> +	case BT_RCVMTU:
> +		if (put_user(sco_pi(sk)->conn->mtu, (u32 __user *)optval))
> +			err = -EFAULT;
> +		break;
> +
>  	default:
>  		err = -ENOPROTOOPT;
>  		break;
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 
