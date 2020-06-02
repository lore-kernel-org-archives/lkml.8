Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A623206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j5FBhoLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFBMp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:45:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40260 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:45:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052CacON189542;
        Tue, 2 Jun 2020 12:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UBDMz9NlvYHl649uFsBp8WuLVJ9aVdmnCyvloWHY3iI=;
 b=j5FBhoLTTvFUfwqLW06mrGaHCgTsehDy5lsbtZWAYbr/d0d1IyKDx2pdQXSkf5ws13gr
 GInvov+URNvOD1xqIM6l2KcUwqrLGSuQGSBwUwIdxJbazfiP5tRoB/QH3YfsB5oJyvnJ
 PbC/7MWs9QHUlC3jrTbzb77fDVI8FW8PF8eAN7m2dw235L+uKNksYu08+4fThRNO4ueX
 cw6fOmhE13jniYBnyXix2ZPxeWIFnhoIX1CxBczbbmJLp4tMN+vgYogosuN7mOL/TZtc
 LsWCd47DT0ZsRRKrmAcm+xAdVxqxo6J87129P8MCQOYBsjmF7+sfrvuw9LGR15bc+Thm 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31bfem3s7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 12:44:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052CcLGU008671;
        Tue, 2 Jun 2020 12:44:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31dju1bycv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 12:44:58 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052CirVp022788;
        Tue, 2 Jun 2020 12:44:54 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 05:44:51 -0700
Date:   Tue, 2 Jun 2020 15:44:39 +0300
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
Subject: Re: [RESEND PATCH v1 5/6] staging: greybus: audio: Add helper APIs
 for dynamic audio modules
Message-ID: <20200602124439.GH30374@kadam>
References: <cover.1591040859.git.vaibhav.sr@gmail.com>
 <c1339e4d57c8b39bd25197d4514fabd868b829b1.1591040859.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1339e4d57c8b39bd25197d4514fabd868b829b1.1591040859.git.vaibhav.sr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:51:14AM +0530, Vaibhav Agarwal wrote:
> +static int gbaudio_remove_controls(struct snd_card *card, struct device *dev,
> +				   const struct snd_kcontrol_new *controls,
> +				   int num_controls, const char *prefix)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < num_controls; i++) {
> +		const struct snd_kcontrol_new *control = &controls[i];
> +		struct snd_ctl_elem_id id;
> +		struct snd_kcontrol *kctl;
> +
> +		if (prefix)
> +			snprintf(id.name, sizeof(id.name), "%s %s", prefix,
> +				 control->name);
> +		else
> +			strlcpy(id.name, control->name, sizeof(id.name));
> +		id.numid = 0;
> +		id.iface = control->iface;
> +		id.device = control->device;
> +		id.subdevice = control->subdevice;
> +		id.index = control->index;
> +		kctl = snd_ctl_find_id(card, &id);
> +		if (!kctl) {
> +			dev_err(dev, "%d: Failed to find %s\n", err,
> +				control->name);
> +			return -ENOENT;

I feel like this should be a continue instead of a return.

> +		}
> +		err = snd_ctl_remove(card, kctl);
> +		if (err < 0) {
> +			dev_err(dev, "%d: Failed to remove %s\n", err,
> +				control->name);
> +			return err;

Probably here as well.  The caller doesn't actually check for errors.

> +		}
> +	}
> +	return 0;
> +}

