Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B6FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024AE2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Recp2UW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBFBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:01:20 -0400
Received: from mout.web.de ([212.227.15.14]:41923 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgFBFBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591074069;
        bh=zHqI1GAMJwZqmIDPE5y3OugxrSVMavbO35UgSeAkYXY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Recp2UW/oYs710LQsfdGOhPF8lrR0tKFkzaW5jZH24wy8MqX+/vrY0Y43ofY8DWIZ
         0h+beahtPRDhWZiy/CYS6fkbZ+X7hwiUZOAb86GLPRbDsp5HR3vSeQSvfevjwDk+ZX
         9E7cTb3RmZz4Ts4Zz3s6c7MSchVr7VBA+lhfpucI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LzsHL-1itft93i9j-0150xe; Tue, 02
 Jun 2020 07:01:08 +0200
Subject: Re: iommu: Improve exception handling in iommu_group_alloc()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        iommu@lists.linux-foundation.org
Cc:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9f8d8308-2056-8e33-7b38-0b7d96e51c3c@web.de>
 <20200602015044.GA89266@VM20190228-100.tbsite.net>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b31fbcd1-b5f8-992b-a994-2a950ab36b61@web.de>
Date:   Tue, 2 Jun 2020 07:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602015044.GA89266@VM20190228-100.tbsite.net>
Content-Type: text/plain; charset=gbk
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IjVHXgPRzlfa123te7yZO+U4OOeKvoJhxBrMAQrVa8Etkvs6hzr
 ozslxFmzsjgF32z4qxORpNQu0oVG9tU8BzPsggnN6HRyO6n8f2lRZPODSdvGXNus00RQvB5
 nXrpYGMVrcD2vZGMuGvA5JEnLdklF7biuvTR6j1o1fNIvMrkpn9jIOn/rK6A9xPCqJR93f+
 Kw6pV4a5BYvjr/HkTms/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LGZxHV+/tWg=:cwNdpUHF3HBFpoxqeaI8nq
 eqZmAQj0ZIxKXCPZWGKZZTwRVRdIuf2XUsbIpF8kP5SAzWjVPgCrQieNA7/sJlAF84a3P9dKF
 S2WRvExAW/yA8f/sKZarIViaiT8SqFpVGaE+wqIxhuTN5r9wfltGIr6PMwezBCp2b6R4jaHEU
 jF0EwWA1s65YCSqrFy4F+3R2Nw+mMV9kz/snqJt6DPbSPxNCI+TTwNraD5Z/j9enue6Jij3u2
 UviizRoZUuTqe5JSqllFaNKAJ78t0M69P8Rh3cndxngkQcSx28sjwnKB76G6rTjtC4+48SIXM
 rwyJu98g7bk6jdsxsq7iCf5kCq90bch/EC7jiloUsp2ODTZ692MDQhEzwPiaeOwo9Lavd8qXA
 rDMSTiupHwAFyvBZ5dJIn+xvHqqjLO2GoxEYW6bGOOTIGz5N/s3UgeqMDVlXcz2fHLqnV/Zht
 vJkSg/T4PYsk4Msvtif9mG2rtLD11pnGR475pl9p32IF/hSZwK8Nl81+KrmCOSaa/v8VVOYVE
 P9ZhgKdqhUcyprpYbVQZ06QGC2KYkLPB26WIS1CJer825QxQZDvBDnR9sLM+IUdS8/x36ECNx
 gmWC+3LePYaHtTztFyKI/xqgE+8c+LcuLXdnLxHxQ+kGL3AXnRZ6lknWbjOy/sAUqTqBSMmEz
 f3YcTBDHfQ+10PV/7Rp4pvKMXlxGe30ckUxfz+GeKSHPyQs9iletV4G9YkvEkvnf9MGFvu6lv
 /529YJqptGmJSebz6Ssb9UiJo0nBo0TDr8VcsDdbQBHy3lQahBq5xz/Bwz8hBRF+d43GzNon6
 +RCEfefI/sZvQJDVaRmM740uj1asg58l475LPt/IxJUyNeJk4RkZnGrb05MPADchwBI3nMWc2
 8ZY6ZnruFvtzk+maivYymTKugGoToK5v/2zl/WlLnECvuzicYQJs4z6cLQ2nAVBMhWVljdI9f
 DEt1mNc3W86W2WhCoIiaS18gYrj6CcJ3mentE3UBeP8POsE9D9lcjzNr1vvS3W2HTuB0cGxM0
 F1Su5sw0CmvgwiEaIRZiUNwlCqU7QgHHWWq40/hr8YmZOXsK4NNS7X+dMUeiFbHykhqhONfkl
 BxbLWThiHnqF+rmILChjqpw0REQiYfAh1ufcqEflgGPWxtFmSyyUyId37UO38GwSwtg8iqkcA
 sMp3mFLvlGv8dqyb8wl4j+qNpWtiej8trbFl4jr2cBgzfgkCZg7ke1/WSQADohNO6oood7ugV
 SX6weTaeM836GfUuu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> * I suggest to avoid the specification of duplicate function calls.
>>   Will it be helpful to add a few jump targets?
>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/coding-style.rst?id=3D3d77e6a8804abcc0504c904bd6e=
5cdf3a5cf8162#n455
>
> I don't think it is helpful or readable to add some jump targets here,
> since the exception handling is very simple here.

Do you disagree to the application of the Linux coding style then
for the recommended exception handling?

Regards,
Markus
