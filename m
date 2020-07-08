Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C846206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtJBpujU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgGHKwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGHKwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:52:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F93C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 03:52:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l2so2458365wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BVfbx6JYCGybhSp5VVxSRuzJ6+B1uWCcaOWMtHryf0k=;
        b=PtJBpujULM2X5uBTwGpWQUIIb3qnMZp4m00DLUidRI/xfPKr7uZ5pTE0oWgDc+CdNs
         uAL7y/qEN2eUuMzzw+tzJipsO7SfdSPGX6GzxwKqXwPGKx1zx7OcmPb66cSH/L0hePhV
         jTGLM4PFJoMoMIe+zN7Ex6l5aS1epKST8lTobPcn+KUw3rgpfN4JmzkczfJL60hKqp0A
         v0vLWcayNIpfAkokPzSk/3s5ld58UDrgeJsvpn0fxTbGcaMIFBGmlj0YVmICv1Q7h5Vu
         s4U2yrnvnFKzt0uLXlGrJxHlDbbI/0R/QbUWMdEUz01BKDUBMZyLAwHQGyrJlm6bWQhV
         2KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BVfbx6JYCGybhSp5VVxSRuzJ6+B1uWCcaOWMtHryf0k=;
        b=ZzJLQJ8Iow9PMNgEHk98jK1rPcCuMOPtPPu2UQp+0tWAfGnPmw+sZ4Ayo/gHOBx/7j
         ofqHTOFWvSuvcAbhBjPBDaJotvIG2NfX/iLccxOuBZ2uyOSW4Lh/JfSBuDNJ1mpaQmHD
         koLj2Opb1/NlM69JhMcsWS6hbYo7MOxkCWN6+BjYC4LuAFgXG/B81Jiaj6Vl62jQm+Mm
         deMdNI5BsMUNCmMzKkvAE+bL5HkUFcSxvEzi9pmG/5jX2qwspZ43/wZki/f5jCW7VClh
         CZWpJWcxcjzgwFev56sGHwtLVAPz+c6SPoo5sHxBQk+e7teIQ9lKGR/Pu+4z6KL6ifPB
         9YEw==
X-Gm-Message-State: AOAM531HU22R0oz/1WjjZAeG73DZFxrbYtH/Azi0HEeBm4CXnZB9sPD6
        FHWe8v/pLvdbSVOakcZEipP1p0Bl
X-Google-Smtp-Source: ABdhPJyXEeTOA8g3Gt6XB63ddVgA+ZzMuR+OR4SDeabkCqtR5R6dy5v+8jms4sVWhnl3JrHRHSH0yA==
X-Received: by 2002:a1c:bb03:: with SMTP id l3mr8285826wmf.24.1594205567975;
        Wed, 08 Jul 2020 03:52:47 -0700 (PDT)
Received: from [192.168.43.42] ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id u16sm5331600wmn.11.2020.07.08.03.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 03:52:47 -0700 (PDT)
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1cceba0f-c8ad-260d-9a09-5417bee32d50@gmail.com>
 <20200706181052.174c290a@oasis.local.home>
 <717030b7-ecba-2ca4-39ff-6a5a04a732d4@gmail.com>
 <20200706182819.3467fa32@oasis.local.home>
 <4592008a-16ee-d8c4-4ec3-5e36a268e5d6@gmail.com>
 <20200707204241.36bea66a@hermes.lan>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <058cea17-7009-c3e9-8c58-9b9ef44b85eb@gmail.com>
Date:   Wed, 8 Jul 2020 13:51:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200707204241.36bea66a@hermes.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2020 06:42, Stephen Hemminger wrote:
> On Tue, 7 Jul 2020 02:03:36 +0300
> Pavel Begunkov <asml.silence@gmail.com> wrote:
> 
>> On 07/07/2020 01:28, Steven Rostedt wrote:
>>> On Tue, 7 Jul 2020 01:17:47 +0300
>>> Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>   
>>>> Totally agree with you! But do we care then whether two _devices_ or _objects_
>>>> are slave-master? Can't see how it fundamentally differs.  
>>>
>>> The term slave carries a lot more meaning than subordinate. I replied to
>>> someone else but later realized that the person sent me their reply
>>> offlist, so my reply to them was also offlist. What I told them was,
>>> back in college (decades ago), when I first mentioned "master/slave" in
>>> conversation (I think it was about hard drives), a person in that
>>> conversation stated that those were not very nice terms to use. I blew
>>> it off back then, but after listening to more people, I found that
>>> using "slave" even to describe a device is not something that people
>>> care to hear about.  
>>
>> That's cultural, but honestly I've never seen such a person. I still
>> don't understand, why having secondary or subordinate object belittling
>> the owned side by not providing it the same rights and freedom is OK,
>> but slave/master objects are not. Where is the line?
>>
>>
>>>
>>> And in actuality, does one device actually enslave another device? I
>>> think that terminology is misleading to begin with.  
>>
>> As mentioned, I do like good clear terminology, and if it conveys the idea
>> better, etc., then it's worth to try. And IMHO that's the right reasoning
>> that should be behind. Otherwise, for almost every word we can find a person
>> seeing something subjectively offensive or at least bad in it.
> 
> Wherever possible the kernel should use the same terminology as the current
> standard in that area. Many of the master/slave references in the networking
> code are for protocols based on IEEE 802 standards (unfortunately paywalled).
> The current version of those standards do not use this kind of wording and the
> standards committees are also actively working on inclusive language statemets.
> 
> As far as the use of master/slave for bonding, bridge, team etc, it
> looks like Linux just invented using those terms since I don't see it
> any other vendors implementations Cisco/Juniper/Arista/... Linux terms
> are different than industry norms in networking, this is not a good
> thing. But changing human expectations is hard.

And that's a perfectly convincing argument for a change -- consistency makes
it easier to work with specs and code. I've never said anything against.

I care about arguments being logically sound, as yours are. And the author
neither provides such, nor IMHO actually helps the issues it raised.

-- 
Pavel Begunkov
