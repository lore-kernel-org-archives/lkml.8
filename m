Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E640FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 17:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA62D206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 17:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="DuV+Hv67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgFURua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbgFURua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 13:50:30 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F37C061796
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 10:50:30 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id f2so2899593ooo.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Z6fzJhAJ321ixT62OQUqlN+rS3fNSQjyBcE/UbACpjY=;
        b=DuV+Hv67MaBq/Ob9oSfvtuHDVbHw+hTc1Rh2pjsk3L2pz2XMiMqoE3QJEm3HSaw1r9
         c1YeAShi164lcWNcHfksX1W4SQxanHh7P+HY+cg9U1tkSOyxtZxuSpql8vQVmXMMeqkp
         GGr6GihsauMjg+brMyPGAwjLpg6i+n5JEBe3aP8NTrRh7jYAMldFWzELXU+jw+X2pbID
         /cE7vM75UQ/jkR9QOC2PFwCnWYY4LXfgxq4J5sCHpZ+EA6mokiRQLPUQulEVukoGZs1+
         naCfyaX3MB20rZ5dXp+tJ8NcqIuCvwxEaHqb+7pZtZRwUirJcEi61G7Ca3TeHPPLRiio
         3zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z6fzJhAJ321ixT62OQUqlN+rS3fNSQjyBcE/UbACpjY=;
        b=rv1uigWUPwrk/p2vh4PkZVj8TzLJd+ypcOZ9PdpV5dc8xpAUe/YzpSQRrEk0aDwfe4
         sSaChA6apDSr8wWLg1vg9fUoTveCIfB9xyPbtdp8YXHnsm0822oy6abkl4agQuafIR68
         cJcM0Yvrjj5C80rOqqf3ObqgzrjKwaiT6xE779aLYomcAnegKnKA/Nk4wA8R0FK+NDsK
         3/Jn0vTkd7CkoBJJVRyiJxxHu2P2R+6wJfAUgeYKLSSinHgFa+zDE2E3SocFd23LUC9x
         3+0se7UQVzTN8vCzF5mlNQe5B9+IQbTXzsXGgEU6pvddp7Y8VyhWhKZ6xxZBCjAZ+MMX
         WOvw==
X-Gm-Message-State: AOAM531YyAOe5AQVoovCocJ4WqNajnQBhkRUzgSbOFh5DcIRdc3NiRHK
        KF58rG1MXXq7dN+xToc1QTF0oPtn71zhWg==
X-Google-Smtp-Source: ABdhPJxCbibHRQuCBo8z043+guNjnBrsjVmhvo/gNbpQNm3dzjFOs/kMOstmC4c83XVlt+0qkUZo8A==
X-Received: by 2002:a4a:ca8b:: with SMTP id x11mr11267088ooq.83.1592761828953;
        Sun, 21 Jun 2020 10:50:28 -0700 (PDT)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id a9sm2733424otr.15.2020.06.21.10.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 10:50:28 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] scsi: ufs: add write booster feature support
To:     Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1586374414.git.asutoshd@codeaurora.org>
 <3c186284280c37c76cf77bf482dde725359b8a8a.1586382357.git.asutoshd@codeaurora.org>
 <CAF6AEGvgmfYoybv4XMVVH85fGMr-eDfpzxdzkFWCx-2N5PEw2w@mail.gmail.com>
 <SN6PR04MB46402FD7981F9FCA2111AB37FC960@SN6PR04MB4640.namprd04.prod.outlook.com>
 <20200621075539.GK128451@builder.lan>
 <CAF6AEGuG3XAqN_sedxk9GRm_9yK+a4OH56CZPmbHx+SW-FNVPQ@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <ba3873e3-75e0-a55f-6a93-d7d8df4da0e9@kali.org>
Date:   Sun, 21 Jun 2020 12:50:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAF6AEGuG3XAqN_sedxk9GRm_9yK+a4OH56CZPmbHx+SW-FNVPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/20 11:50 AM, Rob Clark wrote:
> This looks like a device issue to be taken with the flash vendor:
>> There's no way for a end-user to file a bug report with the flash vendor
>> on a device bought from an OEM and even if they would accept the bug
>> report they wouldn't re-provision the flash in an shipped device.
>>
>> So you will have to work around this in the driver.
> oh, ugg.. well I think these msgs from dmesg identify the part if we
> end up needing to use a denylist:
>
> scsi 0:0:0:49488: Well-known LUN    SKhynix  H28S8Q302CMR     A102 PQ: 0 ANSI: 6
> scsi 0:0:0:49476: Well-known LUN    SKhynix  H28S8Q302CMR     A102 PQ: 0 ANSI: 6
> scsi 0:0:0:49456: Well-known LUN    SKhynix  H28S8Q302CMR     A102 PQ: 0 ANSI: 6
> scsi 0:0:0:0: Direct-Access     SKhynix  H28S8Q302CMR     A102 PQ: 0 ANSI: 6
> scsi 0:0:0:1: Direct-Access     SKhynix  H28S8Q302CMR     A102 PQ: 0 ANSI: 6
> sd 0:0:0:0: [sda] 29765632 4096-byte logical blocks: (122 GB/114 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 32 00 10
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports
> DPO and FUA
> sd 0:0:0:0: [sda] Optimal transfer size 786432 bytes
> scsi 0:0:0:2: Direct-Access     SKhynix  H28S8Q302CMR     A102 PQ: 0 ANSI: 6
> scsi 0:0:0:3: Direct-Access     SKhynix  H28S8Q302CMR     A102 PQ: 0 ANSI: 6
>
>
> (otoh I guess the driver could just notice that writeboost keeps
> failing and stop trying to use it)
>
> BR,
> -R


FWIW, I see this on my c630 as well, but my LUN shows up as


scsi 0:0:0:49488: Well-known LUN    SAMSUNG  KLUDG4U1EA-B0C1   0500 PQ:
0 ANSI: 6

