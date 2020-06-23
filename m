Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE366C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2BE20771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/51c5fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbgFWH2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731057AbgFWH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:28:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C72C061573;
        Tue, 23 Jun 2020 00:28:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t194so2061817wmt.4;
        Tue, 23 Jun 2020 00:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eAOzaLEvri148C9yhZfXxhkQ6ShWPHEsBtHOhazXNYw=;
        b=k/51c5fP79PIPvtCdg/zzQVAGamF8aZgZZitf+FsnsPgs4L+4fjxxcE00SkMX+0WzW
         klVODQPpnEBqm1ZF8kyQacSFxCsrNU/2bNIbDPwdV2l3nyPc3Z7mGBxNbovGYGxd9W8U
         b8Yp5e3hOKBwUPBrPrn0iSJl6tQ+jpA3xtmE6yxzTKPo8aUKjpixYGyUOPYOzBVTGvcf
         AtcPOLanSux/ja1dFIArUpv4dWAzenGbBGwxxoClNJRvyp6r7htdfPcuIgcZjM05l6z6
         HFQPVrvf/lLJmfWgL4NcoorNrlKFyL0c0oM7SChGvlZZP/j+L52eZlnb54arWnNoH0MD
         mq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eAOzaLEvri148C9yhZfXxhkQ6ShWPHEsBtHOhazXNYw=;
        b=VATVWVj0sbU7e42+pZrisTbneuxcXhzwTDyoRDUQAWf4UsQilhh/bKFbNzFWqXVE3A
         J49cVOSBoS0k6+DXxmnTtP3ZJn/8GemsUFmUquDxGn3rV+nhWKK6Nm4mRJgubxoUXFXJ
         EjOc7HBseI1phsp40rkJJGiYMlsmXmUls5qWZ9GGYA+xSuKBtJ3DFf9MfcqTYZjzA8yZ
         Zww85TuMrvom+wcaOkpilOYmA4zosM12azvyA4qR7ulYkPyrLy1WACuRhLIkCVRNbfd/
         JydEpUSvmD5LepZjO8VnKLqWiXTUajLM7juGtESLqEl5bZzF1JqrV2vXwEbw+1N8esdR
         whJg==
X-Gm-Message-State: AOAM533PHPI/0ODZm/7Rno05aJDTWHRXizglnmh9uILRkuGjaJM6xDzv
        B3+gWJJuzofblxhxwpsaiwHgQsx+/8g=
X-Google-Smtp-Source: ABdhPJzuz4+aXy0DOjxqXCya5QX3G7FXScweqlUDkFN+8wby91HADp2yldiuF1+TtlQwjLBQ2at4Ig==
X-Received: by 2002:a1c:6102:: with SMTP id v2mr20964522wmb.6.1592897314040;
        Tue, 23 Jun 2020 00:28:34 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id 185sm2496882wmz.22.2020.06.23.00.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 00:28:33 -0700 (PDT)
Subject: Re: New mode DM-Verity error handling
To:     JeongHyeon Lee <jhs2.lee@samsung.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, agk@redhat.com, corbet@lwn.net
References: <CGME20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25@epcas1p4.samsung.com>
 <98eac3fc-c399-625d-5730-29853b3a0771@samsung.com>
 <20200618154444.GB18007@redhat.com> <20200618165006.GA103290@google.com>
 <20200618170952.GA18057@redhat.com>
 <b7eaf4a7-6692-ffdf-2bbc-b622f93ef601@gmail.com>
 <250156a6-a2d6-dbfd-daa3-be9c36f0cf36@samsung.com>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <2c3bf8c1-c742-b1e9-6ff6-91b2253638e1@gmail.com>
Date:   Tue, 23 Jun 2020 09:28:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <250156a6-a2d6-dbfd-daa3-be9c36f0cf36@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2020 01:53, JeongHyeon Lee wrote:
> 
> For what reason isn't panic better?

I did not say panic is better, I said that while we have restart already in mainline dm-verity code,
panic() is almost the same, so I see no problem in merging this patch.

Stopping system this way could create more damage if it is not configured properly,
but I think it is quite common to stop the system as fast as possible if data system integrity
is violated...

> If when i suggested new patch, i will send you a patch that increased 
> minor version.

I think Mike can fold-in version increase, if the patch is accepted.

But please include these version changes with every new feature.

Actually I am tracking it here for dm-verity as part of veritysetup userspace documentation:
  https://gitlab.com/cryptsetup/cryptsetup/-/wikis/DMVerity

Thanks,
Milan

> On 22/06/2020 16:58, Milan Broz wrote:
>> On 18/06/2020 19:09, Mike Snitzer wrote:
>>> On Thu, Jun 18 2020 at 12:50pm -0400,
>>> Sami Tolvanen <samitolvanen@google.com> wrote:
>>>
>>>> On Thu, Jun 18, 2020 at 11:44:45AM -0400, Mike Snitzer wrote:
>>>>> I do not accept that panicing the system because of verity failure is
>>>>> reasonable.
>>>>>
>>>>> In fact, even rebooting (via DM_VERITY_MODE_RESTART) looks very wrong.
>>>>>
>>>>> The device should be put in a failed state and left for admin recovery.
>>>> That's exactly how the restart mode works on some Android devices. The
>>>> bootloader sees the verification error and puts the device in recovery
>>>> mode. Using the restart mode on systems without firmware support won't
>>>> make sense, obviously.
>>> OK, so I need further justification from Samsung why they are asking for
>>> this panic mode.
>> I think when we have reboot already, panic is not much better :-)
>>
>> Just please note that dm-verity is used not only in Android world (with own tooling)
>> but in normal Linux distributions, and I need to modify userspace (veritysetup) to support
>> and recognize this flag.
>>
>> Please *always* increase minor dm-verity target version when adding a new feature
>> - we can then provide some better hint if it is not supported.
>>
>> Thanks,
>> Milan
>>
>>
