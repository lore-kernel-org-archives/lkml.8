Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D593120866
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="myKIqTxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCFSlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:41:07 -0500
Received: from mout.web.de ([212.227.17.12]:38271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCFSlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583520029;
        bh=VpQKds6DmBjxYxMo4bRHAneIntTDz8NFcYECzbjnX3U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=myKIqTxvAquDWNPfVWg1Z+IkBKGTQ3yt3au4m7aA+IvjQJIOG2nTlsXJrOi/7cUoo
         NZkStRFc3UMv3xyTU9vdpjle22YAapu301rMQcPj6vqfeilVD3OW/QyQPYKu07qpAL
         GKlXppDUeLKVEwkJk0GwdPcQdOhcnCOfzLimnhR0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.156.79]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8zSL-1j55lo1Hav-00CRFS; Fri, 06
 Mar 2020 19:40:29 +0100
Subject: Re: [v5.1] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <158341540688.4236.11231142256496896074.stgit@devnote2>
 <f3c51b0a-2a55-6523-96e2-4f9ef0635d9f@web.de>
 <20200306105107.afba066a97db1eb12f290aff@kernel.org>
 <58f4d6b3-ce3d-d1a5-aa0f-c31c1bbec091@web.de>
 <20200306230406.dd9c7358f00f47ff5760c899@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7a518d51-db04-ac56-fab8-5bc6be8f5b1c@web.de>
Date:   Fri, 6 Mar 2020 19:40:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306230406.dd9c7358f00f47ff5760c899@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8r4yBHVUsRNrpnFVx2TQdhqPZ2AbqA6iWe7oNyKM7pRszuOJsQ2
 9IOBinuYEBSY4lCTUCZgt5HcpoFFC1BS02g7r2E5Web+j4dfbib7EnZZAIAXGdVm8DoCx47
 nynbhWHf2Nc2W/Xe7GgRvMVdmVqlXnturX62Aw/H9iGAy0FrHxc9Vy5KzQKvJ0A2WFC1M4z
 JxeJyuifYvR74v3bWZjEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ZaFRmdW/WM=:DRfa/M33hHJFSzlR8x4iTP
 1RtcIzcY/vJZIyYaeOQpyY8O9MtABnMpnDPMqmqPmJNaC6s971ab6Y9Jpofsgy9ge4nMj+3eI
 Dps7dTNUxaZdtXtY9N6ixFiPFky0i98Tdhugec0AZRJmcPC4JfQEl7Tk2cyWZPg5QO9jwZLIE
 n3vt/5xScdv3H4VQKRrhiUUjSk6osjDnFB2p3zwyAnepXc098kNxUkBEaEIa5vxImYEOy2UFX
 k91N0++IabfywDon3PFfme89RV7GBJ6vaQXa2CPlgsk7MJ4XE0fq9q/lM8sUHv+eaZ83AFbdm
 Y2JEvQGjXgFTX4fl9O6wXJbpJQho5TfypwlvwWsxExyxGihNylK5wEefO+RaiRl1OXpzv63CX
 E/13WZvjmvMqAWooT24BY5aLkfdxwfrI+lRfppMYGhKis5ukLGTeoCAXlNN0RTxFc0LPRHS2G
 cxn3nL4bY3ayjxDu7QNkcYGtsJyjd85+y+IAEyfkA2QZZ3HbBnmRZKIVSdo28qOX86DdQuR/1
 H5l1sgeM9jTHkq0QK7QwkRZEV82xaZaEzKRA7eVP+ZqfGzDt8kcq9TlA4FuryQ9RB+m5Hm3IN
 PRAQ+lpZl5u+/2ZHXMEC/GmuLsecPRnJ1VT3p/FLjqHHWeTwQD6tJFJuX+CMqLJ7ZKOtprx4r
 gK94rAAlbVCIHNUvEAk6iaijPcwwJfZRU/yR85lRTaa8stlzDJIk141/65I65cKAD3Qw9UrOU
 B0tWi5kE0BqPhOguTfT9m4A7ubG9nuheJV9KQ2ayJiaydSNkzHHfYj6bXaKV1ugRg0IEp9M5p
 GdvYPUVPD/g+9wWrw9IB7AExsse1ngydLnJiRWYRgl4Zc1lD59c3HQI3YlSdlQAueM/wx0p1P
 9UY+RGSrWqxcW23jI0loaetCcNhiSNys5WHCQlNTdycuApPcdG0gk0wB5oT02dWrbvXlNxgPn
 M3iZRFKLkjv9WWGy0PG8sG8JFnjvpkRHV8DX/N7vj7UNOG9sTTOumMc2InCjje3iWOHM3Wi0U
 5Iz06c/kfHTQiWhKpSc6oAu8lEKa0X3Tw4LMG7DrDzyAu1IzzunMp1iDNNGCoKL+s1Oe94WLD
 kLtP8YUgV+wwFTIhayws/nbt4gooE7/Cf8x+b1HLrrlppLMgd6CaN/DDbb/jTFGi8Ab7Uq8bo
 MSlXasinW+jxwKZMYXz3A7sumRfoi9SGz+R53b/y/jTVYv8V1lEwBDTIl9/dRiAMpH6vUfTRV
 ryW0VVx7MXdpGlE86
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> =E2=80=A6
>>>>> +++ b/Documentation/admin-guide/bootconfig.rst
>>>> =E2=80=A6
>>>>> +If you think that kernel/init options become too long to write in b=
oot-loader
>>>>> +configuration file or you want to comment on each option, the boot
>>>>> +configuration may be suitable. =E2=80=A6
>>>>
>>>> Would you like to specify any settings in the boot configuration file
>>>> because the provided storage capacity would be too limited by the ker=
nel command line?
>>>
>>> Yes.
>>
>> How will affected places be improved after such an agreement?
>
> Would you please make a patch of new sentence?

Not directly.

* If I would need to provide another wording alternative as a concrete pat=
ch,
  I would have to wait until previously accepted changes would become avai=
lable
  in a Linux development repository.

* So I would find it easier to agree on wording variants during our curren=
t
  development discussion from which you would present results as a subsequ=
ent patch.

Regards,
Markus
