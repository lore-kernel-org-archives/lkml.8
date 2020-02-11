Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCBBC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED05F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=serbinski.com header.i=@serbinski.com header.b="Ssoit/C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgBKNwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:52:32 -0500
Received: from mail.serbinski.com ([162.218.126.2]:54546 "EHLO
        mail.serbinski.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgBKNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:52:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id CADA7D006F9;
        Tue, 11 Feb 2020 13:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
        by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MnOnwGJcKCEn; Tue, 11 Feb 2020 08:52:23 -0500 (EST)
Received: from mail.serbinski.com (localhost [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id 4F86CD00693;
        Tue, 11 Feb 2020 08:52:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com 4F86CD00693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
        s=default; t=1581429143;
        bh=4UgsNF2DfSAJSAEAuD7fkyhncR/ncVh8kAIH7kgJv2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ssoit/C7jtU+uEyLBQlHyTfLDiONn8FBviOZQ0wZQ7bzpeDh/52Y6RjL0hK95iw6w
         CAsfhZGI5lqAnLqnO/pA3fRbCr2t+TeGXKjon6ZvGiVTc+vduNIAZmmKhNUTBOCw0b
         nwYbCqj3d60oW8U+tkAROVgAxx84Q5ivNylYa9tA=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Feb 2020 08:52:23 -0500
From:   Adam Serbinski <adam@serbinski.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] ASoC: qcom: apq8096: add kcontrols to set PCM rate
In-Reply-To: <20200211114256.GC4543@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-9-adam@serbinski.com>
 <20200210133636.GJ7685@sirena.org.uk>
 <18057b47c76d350f8380f277713e0936@serbinski.com>
 <20200210182609.GA14166@sirena.org.uk>
 <f88d21773f47f5a543a17ad07d66f9b7@serbinski.com>
 <20200210200839.GG14166@sirena.org.uk>
 <7c57801d8f671c40d4c6094e5ce89681@serbinski.com>
 <20200211114256.GC4543@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4-beta
Message-ID: <b386237a1c21a417afb25f79a8b3d4ce@serbinski.com>
X-Sender: adam@serbinski.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-11 06:42, Mark Brown wrote:
> On Mon, Feb 10, 2020 at 04:13:52PM -0500, Adam Serbinski wrote:
> 
>> I am not aware of how this could be done for bluetooth, since the 
>> value
>> still has to originate from userspace. The driver you referred to 
>> supports
>> only a single sample rate, whereas for bluetooth, 2 sample rates are
>> required, and nothing in the kernel is aware of the appropriate rate, 
>> at
>> least in the case of the qca6174a I'm working with right now, or for 
>> that
>> matter, TI Wilink 8, which I've also worked with.
> 
> There's generic support in the CODEC<->CODEC link code for setting the
> DAI configuration from userspace.

Ok. Its going to take some time to get my head around that, so for the 
time being I'm going to drop this feature and get the rest fixed for 
inclusion.

Thanks.
