Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0312BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BD7204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FGWALejk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgFJRqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:46:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgFJRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:46:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AHgSRg117414;
        Wed, 10 Jun 2020 17:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bh8nRt1h0Qm9YLYmWJZrmpvVO8pZdtpV1B7rl5d/bQ8=;
 b=FGWALejkISxJxpEpJrf8+0+MJhbzo9hCw7OBEl7AtnZxwTJFFyEjm4LJwMTCTlLFgRUW
 m+JUZHyey6kjQY0hu8nLAkFDNdpIdqLhHLo8OfvrNhFBgwvdzNbUGE6l87HE/t/yXbud
 4D2dSKDY4pENNtfUvqmgr44q11BQhQ5e4nQfu7d2UQQLh9JvdnoTgBoNMnmfD6193YBa
 60a9JVEI0UqhatMKd284cu3Ru0s0wl9pB5X2b3KZSm6u9sd2vZP3sitqdiElVU8rT3gA
 ENs84eDnBNVuhu/C0lBsM9R3qIqjN21cxrSAAp+AOfxACrYPckKT9Fn82f2wNasI/fO0 Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31g2jrbs3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 17:45:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AHiR8H109394;
        Wed, 10 Jun 2020 17:45:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31gmwtm39q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 17:45:54 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05AHjjda010613;
        Wed, 10 Jun 2020 17:45:49 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 10:45:44 -0700
Date:   Wed, 10 Jun 2020 20:45:35 +0300
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
Subject: Re: [PATCH v2 4/6] staging: greybus: audio: Resolve compilation
 error in topology parser
Message-ID: <20200610174535.GB4151@kadam>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <7cbb81585474e895faa842e2af05ec3fb2079386.1591802243.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cbb81585474e895faa842e2af05ec3fb2079386.1591802243.git.vaibhav.sr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:58:28PM +0530, Vaibhav Agarwal wrote:
> @@ -437,11 +433,12 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
>  	struct gbaudio_module_info *module;
>  	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
>  	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
> -	struct snd_soc_codec *codec = widget->codec;
> -	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
> +	struct device *codec_dev = widget->dapm->dev;
> +	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
> +	struct snd_soc_dapm_update *update = NULL;
                                    ^^^^^^^^^^^^^

>  	struct gb_bundle *bundle;
>  
> -	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
> +	dev_dbg(codec_dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
>  	module = find_gb_module(gb, kcontrol->id.name);
>  	if (!module)
>  		return -EINVAL;
> @@ -458,17 +455,13 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
>  	max = le32_to_cpu(info->value.integer.max);
>  	mask = (1 << fls(max)) - 1;
>  	val = ucontrol->value.integer.value[0] & mask;
> -	connect = !!val;
>  
>  	/* update ucontrol */
>  	if (gbvalue.value.integer_value[0] != val) {
>  		for (wi = 0; wi < wlist->num_widgets; wi++) {
>  			widget = wlist->widgets[wi];
> -
> -			widget->value = val;
> -			widget->dapm->update = NULL;
> -			snd_soc_dapm_mixer_update_power(widget, kcontrol,
> -							connect);
> +			snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol,
> +							val, update);
                                                             ^^^^^^
Always NULL.  Just delete the update variable.

regards,
dan carpenter


