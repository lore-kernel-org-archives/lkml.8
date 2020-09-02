Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0932AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9ED206E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIBL4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:56:30 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:48868 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:56:25 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 85710F1D;
        Wed,  2 Sep 2020 19:56:03 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.76] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22908T140609325295360S1599047762080218_;
        Wed, 02 Sep 2020 19:56:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a9124768c8cbdf58211f153dc645d451>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2] drm/of: Consider the state in which the ep is disabled
From:   Huang Jiachai <hjc@rock-chips.com>
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, kever.yang@rock-chips.com,
        linux-kernel@vger.kernel.org
References: <20200707112526.18438-1-hjc@rock-chips.com>
 <3361390.LkKjKlf5PX@phil>
 <12d1b648-81d1-df48-4435-b7b88dd72b30@rock-chips.com>
Message-ID: <fc4aab7b-c1e5-4469-8ccd-4529055e05a1@rock-chips.com>
Date:   Wed, 2 Sep 2020 19:56:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <12d1b648-81d1-df48-4435-b7b88dd72b30@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David Airlie，

     Please help to confirm whether this modification is reasonable when 
you are free, thanks.


在 2020/8/13 14:31, Huang Jiachai 写道:
> ping...
>
> 在 2020/7/23 3:01, Heiko Stübner 写道:
>> Am Dienstag, 7. Juli 2020, 13:25:26 CEST schrieb Sandy Huang:
>>> don't mask possible_crtcs if remote-point is disabled.
>>>
>>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>>
>> changes in v2:
>> - drop additional of_node_put, as ep will be put with the next
>>    iteration of for_each_endpoint_of_node()
>>
>>
>> As this touches a pretty central function is there something
>> to keep in mind in regards to other DRM drivers?
>> [question for the broader audience ;-) ]
>>
>> Heiko
>>
>>> ---
>>>   drivers/gpu/drm/drm_of.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
>>> index fdb05fbf72a0..565f05f5f11b 100644
>>> --- a/drivers/gpu/drm/drm_of.c
>>> +++ b/drivers/gpu/drm/drm_of.c
>>> @@ -66,6 +66,9 @@ uint32_t drm_of_find_possible_crtcs(struct 
>>> drm_device *dev,
>>>       uint32_t possible_crtcs = 0;
>>>         for_each_endpoint_of_node(port, ep) {
>>> +        if (!of_device_is_available(ep))
>>> +            continue;
>>> +
>>>           remote_port = of_graph_get_remote_port(ep);
>>>           if (!remote_port) {
>>>               of_node_put(ep);
>>>
>>
>>
>>
>>
>>
-- 
Best Regard

黄家钗
Sandy Huang
Addr: 福州市鼓楼区铜盘路软件大道89号福州软件园A区21号楼(350003)
       No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
Tel：+86 0591-87884919  8690
E-mail：hjc@rock-chips.com



