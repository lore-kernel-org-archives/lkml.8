Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BF0206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bU4zfy0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgFBM60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:58:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34054 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgFBM6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:58:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052Cq4g5026266;
        Tue, 2 Jun 2020 12:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=GZDp8wmQt7YFI5yVG/apFRbBuqEEBQ8exPXA3c138bM=;
 b=bU4zfy0SbhOb+nqYhPsTEAFVkGDExsLmEB/8tMGfh8MnrFfpsF1j9nngBvou6GMxCvNA
 rWV3UZXnJwlTlw1Hy1RHTocBAk/NGmoUtzRqEcT69pLSdlqGO7ncq5pL7n2KyFc+8c1x
 TkACg+4YY95h2fxJYJ60jmieqyBw8V1QC7eblJnPHV6bbFXamahuIc43GyEt4txCIgJO
 jDRmApha7fit3F63FELdhKOCEPJrqGjAvk3G0wBPo6Ko9crKhhzXT1ekd+FzAvlCBsPZ
 g7Y5I1pmc27RStbmJ9FDNd0A61TLnzYmcMb9D2sUIGTCOVZPlHZrhNWahXBNIp21ND7P HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31dkrugwvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 12:57:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052Crvvq086376;
        Tue, 2 Jun 2020 12:57:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31c25ntsb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 12:57:33 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052CvShi031357;
        Tue, 2 Jun 2020 12:57:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 05:57:27 -0700
Date:   Tue, 2 Jun 2020 15:57:15 +0300
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
Subject: Re: [RESEND PATCH v1 6/6] staging: greybus: audio: Enable GB codec,
 audio module compilation.
Message-ID: <20200602125715.GI30374@kadam>
References: <cover.1591040859.git.vaibhav.sr@gmail.com>
 <77cfc355b87ee21636430f787764700de1983f38.1591040859.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77cfc355b87ee21636430f787764700de1983f38.1591040859.git.vaibhav.sr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:51:15AM +0530, Vaibhav Agarwal wrote:
> Currently, GB codec and audio module is conditionally compiled based on
> GREYBUS_AUDIO_MSM8994. However, audio module is not dependent on MSM8994
> platform and can be used generically with any platform that follows
> GB Audio class specification.
> 
> Also, GB codec driver corresponds to dummy codec represented by I2S port
> available on Toshiba AP Bridge. Added config option for the same in
> kconfig file and accordingly updated Makefile.
> 

This commit message was a bit confusing to me.  Just say:

"Currently you can't enable the Grey Bus Audio Codec because there is no
entry for it in the Kconfig file.  Originally the config name was going
to be AUDIO_MSM8994 but that's not correct because other types of
hardware are supported now.  I have chosen the name AUDIO_APB_CODEC
instead.  Also I had to update the dependencies for GREYBUS_AUDIO to
make the compile work."

Otherwise this looks fine.

regards,
dan carpenter

