Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693D12053B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CV1fSdhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgFBMbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:31:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:31:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052CMgWu171643;
        Tue, 2 Jun 2020 12:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lu3BbalZdQaF6ggOh0dU1HA0oIChyA8n999bSv8rs1I=;
 b=CV1fSdhuZ0iQ3oob4rEqjrNg24OX373xXBOPl1MYMnHZ+u9uHPq2swUHPIQeBLeslUiX
 F+0N4Tgi0js6b9BgLW0nH54Su+lgf64krT/SddzqlAK8t3jKwzgJ3wim7zt9xtrK9yZN
 AAyzcpKLqd4PWVaftAf/MOefzKXmPyIZIyX3lHNYdvIJQRfluRzzWYJuuOSCdlj1rKsk
 HSbfYeH7HxXNc1LxsBkYS/mwjhbiKdgfWsO2g8lzPJRYTU+wh5MrbvV1GFOdB6USgQf5
 4R0lFB5Vz63JGGC6H14lpzjc1j6BqiAazYj3RKg7MAgXol3sMApfg2VCZkrYnl3DI2xe Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31dkrugt0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 12:30:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052CHPkG125784;
        Tue, 2 Jun 2020 12:30:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31c12p3dr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 12:30:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052CTo0j015127;
        Tue, 2 Jun 2020 12:29:54 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 05:29:50 -0700
Date:   Tue, 2 Jun 2020 15:29:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [RESEND PATCH v1 3/6] staging: greybus: audio: Resolve
 compilation errors for GB codec module
Message-ID: <20200602122940.GF30374@kadam>
References: <cover.1591040859.git.vaibhav.sr@gmail.com>
 <cce5aa43533d872d84be1abc514074a7705f9a54.1591040859.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce5aa43533d872d84be1abc514074a7705f9a54.1591040859.git.vaibhav.sr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:51:12AM +0530, Vaibhav Agarwal wrote:
> Due to dependencies on ASoC framework changes, GB dummy codec module
> compilation is currently disabled. This patch updates codec driver as
> per the latest ASoC APIs.
> 
> Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.c | 87 +++++++++++++--------------
>  drivers/staging/greybus/audio_codec.h |  2 +-
>  2 files changed, 44 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index a2ee587e5a79..bbd072acda5c 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -832,7 +832,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
>  int gbaudio_register_module(struct gbaudio_module_info *module)
>  {
>  	int ret;
> -	struct snd_soc_codec *codec;
> +	struct snd_soc_component *component;

I quite like the "component" pointer because it's assigned once at the
start of the function and used consistently throughout.  The other
pointers I complained about were just temporary pointers which meant
different things depending on which line you were on.  They made the
code harder to read.

My only quible is that in the next patch it's called "comp" and here
it's called "component".  Let's just use "comp" for all the local
variables.


regards,
dan carpenter
