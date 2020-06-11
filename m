Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDA6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94126206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HTd6NhjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgFKKnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:43:22 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33648 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbgFKKnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:43:21 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BAdYdW014068;
        Thu, 11 Jun 2020 05:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=hecjCZmbcbcFVoaRPrzhg4UVh2uD/Zn308eU+DldDzo=;
 b=HTd6NhjHsJ1utxmwA+HwNGN2KO2c2C2LCGg81uqtDkR1oKgm7TuPpr3wBOpYertH2Z+l
 jIVyH20CS/nD5nsdvMkn6ET0VedzAr/+2sp4/9Q+iaaWc5r5sLzxK/2RQE/Zs+PyjR20
 weEW5r4d+4JZ5tWZkr7ieAq49PAMNA2GJ2+4vrGfsJIkLQrvtPwmsQiIRArRGR0/lBV/
 bh1HUcc3ZxCsIwE1b86iZT96ZtxuJ0Nlqk6oEyc6JS+ztT8cWU5eG1K5OdamcNX9ZBhk
 0+5bLGQ79XGotvK+bUmKaa3aSAz3NHQDJ8MyyZfV7ojL62XIHkLgzOK2M6wUadpmXf4H TA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 31g8j47t17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Jun 2020 05:42:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 11 Jun
 2020 11:42:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 11 Jun 2020 11:42:34 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 79F5B448;
        Thu, 11 Jun 2020 10:42:34 +0000 (UTC)
Date:   Thu, 11 Jun 2020 10:42:34 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
Message-ID: <20200611104234.GQ71940@ediswmail.ad.cirrus.com>
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
 <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
 <20200610105820.GA1393454@vkoul-mobl>
 <20200611084659.GO71940@ediswmail.ad.cirrus.com>
 <6a984302-ff01-e326-d338-e50e1f532cd9@perex.cz>
 <20200611094423.GB1393454@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200611094423.GB1393454@vkoul-mobl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 cotscore=-2147483648 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 03:14:23PM +0530, Vinod Koul wrote:
> On 11-06-20, 11:09, Jaroslav Kysela wrote:
> > Dne 11. 06. 20 v 10:46 Charles Keepax napsal(a):
> > > On Wed, Jun 10, 2020 at 04:28:20PM +0530, Vinod Koul wrote:
> > > > On 10-06-20, 12:40, Jaroslav Kysela wrote:
> > > > > Dne 10. 06. 20 v 12:07 Srinivas Kandagatla napsal(a):
> > > > > > Here is the sequence of events and state transitions:
> > > > > > 
> > > > > > 1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
> > > > > > 2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
> > > > > > 3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
> > > > > > 4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
> > > > > > 5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
> > > > > > 6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
> > > > > > 7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
> > > > > > 8. set_metadata (Track 3), no state change, state = SNDRV_PCM_STATE_PREPARED
> > > > > > 9. set_next_track (Track 3), !! FAILURE as state != SNDRV_PCM_STATE_RUNNING
> Yeah sorry I overlooked that case and was thinking of it being invoked
> from driver!
> 
> Yes this would make the snd_compr_stop() behave incorrectly.. so this
> cant be done as proposed.
> 
> But we still need to set the draining stream state properly and I am
> thinking below now:
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 509290f2efa8..9aba851732d7 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -929,7 +929,9 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
>         }
>  
>         stream->next_track = false;
> -       return snd_compress_wait_for_drain(stream);
> +       retval = snd_compress_wait_for_drain(stream);
> +       stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> +       return retval;

This is looking better, I think you probably need to make the
switch to RUNNING conditional on snd_compress_wait_for_drain
succeeding, as the state should remain in DRAINING if we are
interrupted or some such.

I also have a slight concern that since
snd_compress_wait_for_drain, releases the lock the set_next_track
could come in before the state is moved to RUNNING, but I guess
from user-spaces perspective that is the same as it coming in
whilst the state is still DRAINING, so should be handled fine?

Thanks,
Charles
