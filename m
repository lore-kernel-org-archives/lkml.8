Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAFAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D946A2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIIJd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:33:58 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:57658 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbgIIJdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:33:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7218F182CED34;
        Wed,  9 Sep 2020 09:33:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: floor94_611501d270dc
X-Filterd-Recvd-Size: 2099
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Sep 2020 09:33:49 +0000 (UTC)
Message-ID: <2530c5c8a596b7edd7e2273cffc3b76ac4b437c7.camel@perches.com>
Subject: Re: [net-next] net: iavf: Use the ARRAY_SIZE macro for aq_to_posix
From:   Joe Perches <joe@perches.com>
To:     Wei Xu <xuwei5@hisilicon.com>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linuxarm@huawei.com,
        shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com,
        john.garry@huawei.com, salil.mehta@huawei.com,
        shiju.jose@huawei.com, jinying@hisilicon.com,
        zhangyi.ac@huawei.com, liguozhu@hisilicon.com,
        tangkunshan@huawei.com, huangdaode@hisilicon.com,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Sep 2020 02:33:48 -0700
In-Reply-To: <1599641471-204919-1-git-send-email-xuwei5@hisilicon.com>
References: <1599641471-204919-1-git-send-email-xuwei5@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-09 at 16:51 +0800, Wei Xu wrote:
> Use the ARRAY_SIZE macro to calculate the size of an array.
> This code was detected with the help of Coccinelle.
[]
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
[]
> @@ -120,7 +120,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
>  	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
>  		return -EAGAIN;
>  
> -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> +	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
>  		return -ERANGE;

If you want to use a cast,

	if ((u32)aq_rc >= ARRAY_SIZE(aq_to_posix))
		return -ERANGE;

would be a more common and simpler style, though
perhaps testing ac_rc < 0 would be more intelligible.

	if (ac_rc < 0 || ac_rq >= ARRAY_SIZE(aq_to_posix))
		return -ERANGE;



