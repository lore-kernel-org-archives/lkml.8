Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A416C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE24D207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ldyHCqL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFKIru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:47:50 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:6686 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbgFKIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:47:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05B8g8DS006204;
        Thu, 11 Jun 2020 03:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=RA8gyM/Boi4nX18h8FqgHUYCugif5lvnF1e0Dqjslrk=;
 b=ldyHCqL6OVILKhdYVG3ldBwKF9gg3jIeoK9awaghoM4AD+XCCnc0/fk+cTnm+MQTAlkX
 l1+7tC9Jbq7zRnq6Pqi4t3/xPzOI24QfL4GaXNyXTJlacv62Dq3o5KLgg6mC4LzNZqJN
 Ywf3Whv6nOF3SP1LUjibfT6yXGSSjHQfh7FqMU34Uu7J4MhfPtyfCwsBst22pe6cXa0l
 MA4cfrpPKN19NeJk2j6eer2JDwiftGiEYEBMgncLdV6d+43vg1EiMSqqaO5yd7G1//kf
 NT0Y6mDR1VdNoHIaal3HgME3uyhLq3sUGrfNRFy2AY1RrTD3gcHqwLdrW3iuVTARo1bd Ew== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31g7jmynde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Jun 2020 03:47:00 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 11 Jun
 2020 09:46:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 11 Jun 2020 09:46:59 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1887B448;
        Thu, 11 Jun 2020 08:46:59 +0000 (UTC)
Date:   Thu, 11 Jun 2020 08:46:59 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
Message-ID: <20200611084659.GO71940@ediswmail.ad.cirrus.com>
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
 <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
 <20200610105820.GA1393454@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200610105820.GA1393454@vkoul-mobl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=953 spamscore=0 impostorscore=0
 cotscore=-2147483648 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:28:20PM +0530, Vinod Koul wrote:
> On 10-06-20, 12:40, Jaroslav Kysela wrote:
> > Dne 10. 06. 20 v 12:07 Srinivas Kandagatla napsal(a):
> > > For gapless playback call to snd_compr_drain_notify() after
> > > partial drain should put the state to SNDRV_PCM_STATE_RUNNING
> > > rather than SNDRV_PCM_STATE_SETUP as the driver is ready to
> > > process the buffers for new track.
> > > 
> > > With existing code, if we are playing 3 tracks in gapless, after
> > > partial drain finished on previous track 1 the state is set to
> > > SNDRV_PCM_STATE_SETUP which is then moved to SNDRV_PCM_STATE_PREPARED
> > > after data write. With this state calls to snd_compr_next_track() and
> > > few other calls will fail as they expect the state to be in
> > > SNDRV_PCM_STATE_RUNNING.
> > > 
> > > Here is the sequence of events and state transitions:
> > > 
> > > 1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
> > > 2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
> > > 3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
> > > 4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
> > > 5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
> > > 6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
> > > 7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
> > > 8. set_metadata (Track 3), no state change, state = SNDRV_PCM_STATE_PREPARED
> > > 9. set_next_track (Track 3), !! FAILURE as state != SNDRV_PCM_STATE_RUNNING
> > 
> > 
> > The snd_compr_drain_notify() is called only from snd_compr_stop(). Something
> > is missing in this sequence?
> 
> It is supposed to be invoked by driver when partial drain is complete..
> both intel and sprd driver are calling this. snd_compr_stop is stop
> while draining case so legit
> 

Not sure I follow this statement, could you elaborate a bit?
snd_compr_stop putting the state to RUNNING seems fundamentally
broken to me, the whole point of snd_compr_stop is to take the
state out of RUNNING.

Thanks,
Charles
