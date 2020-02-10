Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F3C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1FA20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=serbinski.com header.i=@serbinski.com header.b="R95TpP03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBJPpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:45:22 -0500
Received: from mail.serbinski.com ([162.218.126.2]:53018 "EHLO
        mail.serbinski.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:45:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id 8BD69D006F9;
        Mon, 10 Feb 2020 15:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
        by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RU0dbJpuXSmK; Mon, 10 Feb 2020 10:45:16 -0500 (EST)
Received: from mail.serbinski.com (localhost [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id 264F5D00693;
        Mon, 10 Feb 2020 10:45:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com 264F5D00693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
        s=default; t=1581349516;
        bh=cgzaas0LPv50cOT+2MC0flSgiGLs+1OYFMtEFdzI+9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R95TpP03Z2najOK0N607cJhi1GKdKti38DMqwwGSmgYAXHDbUTpNfJy94pKthGMkl
         VY+b5ALw30rca8MF3RzDpXXmgCF4Ua3ISzhn4la3kag0BP7BSKsGxgAWZtmozbwK0M
         aWvAj8ofKAwd9n0MZxeaYQo2yJ+PQjJ8C8R/w9ho=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Feb 2020 10:45:16 -0500
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
In-Reply-To: <20200210133636.GJ7685@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-9-adam@serbinski.com>
 <20200210133636.GJ7685@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4-beta
Message-ID: <18057b47c76d350f8380f277713e0936@serbinski.com>
X-Sender: adam@serbinski.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-10 08:36, Mark Brown wrote:
> On Sun, Feb 09, 2020 at 10:47:48AM -0500, Adam Serbinski wrote:
>> This makes it possible for the backend sample rate to be
>> set to 8000 or 16000 Hz, depending on the needs of the HFP
>> call being set up.
> 
> This would seem like an excellent thing to put in the driver for the
> baseband or bluetooth.

The value that must be set to this control is not available to the 
bluetooth driver. It originates from the bluetooth stack in userspace, 
typically either blueZ or fluoride, as a result of a negotiation between 
the two devices participating in the HFP call.
