Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EDEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CB420714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="uP27SHBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgGVTsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:48:40 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.202]:35903 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgGVTsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:48:39 -0400
X-Greylist: delayed 1268 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 15:48:38 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 04C24418AF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:25:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id yKLBjQFbCSxZVyKLBj2qw5; Wed, 22 Jul 2020 14:23:45 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jJEeIskCU94/uy46H+vlxkYWS0tQWGpTRtC/J7YvjtU=; b=uP27SHBaPuzgMSCx/+bPwwtbXw
        dtKmf6+REHWhATru6rkj220R5+2gwiX7INCBvTl8cRN99t9+g8gzZwMqidh0ZtKtEMKmQbfMZrkAB
        4jdDIgQUHqN3fViUk99eHq/UJJKenBYsppy1iYCs/GdlP+bBuwVh94bs4M4JkYNOCmWwWQlIjYfYL
        6IZJAZxu6lvfSdCA6bKJv049xzjp/CU6VauL1LPk+d5GLfm7OZMgr15O1SLYbvsT9FiREzyVp+FQp
        kA/bBzLmuChOfZDSg8VsD1uyhbGkrcXxLTAy01CGumGH6D2hIVVdO0hvz3+PAScu9lCpsYBzk8iAB
        tQu580jQ==;
Received: from [201.162.161.216] (port=41852 helo=[192.168.43.132])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jyKLA-0014CO-OK; Wed, 22 Jul 2020 14:23:44 -0500
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20200714214516.GA1040@embeddedor>
 <5198b29f-2e62-4910-4a4d-52c7991915c5@embeddedor.com>
 <3cac21c8798b48bdb412a5504126489f@intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Subject: Re: [PATCH v2] mei: Avoid the use of one-element arrays
Message-ID: <b79bbb51-50e4-6437-b485-eaecdb3fa18e@embeddedor.com>
Date:   Wed, 22 Jul 2020 14:29:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3cac21c8798b48bdb412a5504126489f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.161.216
X-Source-L: No
X-Exim-ID: 1jyKLA-0014CO-OK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.132]) [201.162.161.216]:41852
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

Please, see my comments below...

On 7/22/20 14:04, Winkler, Tomas wrote:
> 
>>
>> Hi all,
>>
>> Friendly ping: who can take this? :)
>>
>> Thanks
>> --
>> Gustavo
>>
>> On 7/14/20 16:45, Gustavo A. R. Silva wrote:
>>> One-element arrays are being deprecated[1]. Replace the one-element
>>> arrays with a simple value type u8 reserved, once this is just a
>>> placeholder for alignment.
>>>
>>> Also, while there, use the preferred form for passing a size of a struct.
>>> The alternative form where struct name is spelled out hurts
>>> readability and introduces an opportunity for a bug when the variable
>>> type is changed but the corresponding sizeof that is passed as argument is
>> not.
>>>
>>> [1] https://github.com/KSPP/linux/issues/79
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>> Changes in v2:
>>>  - Use a more concise changelog text.
>>>
>>>  drivers/misc/mei/hbm.c | 4 ++--
>>>  drivers/misc/mei/hw.h  | 6 +++---
>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c index
>>> a44094cdbc36..f020d5594154 100644
>>> --- a/drivers/misc/mei/hbm.c
>>> +++ b/drivers/misc/mei/hbm.c
>>> @@ -408,14 +408,14 @@ static int mei_hbm_add_cl_resp(struct mei_device
>>> *dev, u8 addr, u8 status)  {
>>>  	struct mei_msg_hdr mei_hdr;
>>>  	struct hbm_add_client_response resp;
>>> -	const size_t len = sizeof(struct hbm_add_client_response);
>>> +	const size_t len = sizeof(resp);
>>>  	int ret;
>>>
>>>  	dev_dbg(dev->dev, "adding client response\n");
>>>
>>>  	mei_hbm_hdr(&mei_hdr, len);
>>>
>>> -	memset(&resp, 0, sizeof(struct hbm_add_client_response));
>>> +	memset(&resp, 0, len);
>>>  	resp.hbm_cmd = MEI_HBM_ADD_CLIENT_RES_CMD;
>>>  	resp.me_addr = addr;
>>>  	resp.status  = status;
> 
> This should be probably in a different patch it's not related to the second part.
> 
>>> diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h index
>>> b1a8d5ec88b3..8c0297f0e7f3 100644
>>> --- a/drivers/misc/mei/hw.h
>>> +++ b/drivers/misc/mei/hw.h
> I have second thoughts of this part as all reserved fields in this file are of form u8 reserved[X], 
> so we will lose that uniformity with this change, you have to look at the file as whole
> not just at the patch.  So I prefer we drop that part of the patch. 
> 

This is actually the main point of this patch: the removal of one-element arrays.
And yeah, every place in the kernel that uses the form that you mention will see
it's uniformity slightly modified, and that's for a good cause: the removal of
one-element arrays, so we can enable bounds checking.

Thanks
--
Gustavo

>>> @@ -346,13 +346,13 @@ struct hbm_add_client_request {
>>>   * @hbm_cmd: bus message command header
>>>   * @me_addr: address of the client in ME
>>>   * @status: if HBMS_SUCCESS then the client can now accept connections.
>>> - * @reserved: reserved
>>> + * @reserved: reserved for alignment.
>>>   */
>>>  struct hbm_add_client_response {
>>>  	u8 hbm_cmd;
>>>  	u8 me_addr;
>>>  	u8 status;
>>> -	u8 reserved[1];
>>> +	u8 reserved;
>>>  } __packed;
>>>
>>>  /**
>>> @@ -461,7 +461,7 @@ struct hbm_notification {
>>>  	u8 hbm_cmd;
>>>  	u8 me_addr;
>>>  	u8 host_addr;
>>> -	u8 reserved[1];
>>> +	u8 reserved;
>>>  } __packed;
>>>
>>>  /**
>>>
