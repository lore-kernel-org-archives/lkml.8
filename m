Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E7CC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F68820748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rLXtoT1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAQSUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:20:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34462 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAQSUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:20:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HIDGkp186421;
        Fri, 17 Jan 2020 18:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=oAP13y93/jPKuyY/7iTSKn/384M1UDuNaMgAyH6pLbA=;
 b=rLXtoT1ZHwYlD9TL0kOAXqKUC2yJA+IvPup0iu8qun8aclerOwnDi04i/QoCfqzbAxS2
 ebMGJeBzb5cglNtqbJqWuyvDH5y/yOE9Jz5JxvXKXfhbSttE1fdMKAnyVaFfDTKSef44
 xOAK4vByTXvlgMByAUo2NAU89SbxEuZBhX5WdiwJaqv2Kz+IkhY99KcSWOHnj+HHbqZy
 vdFzW4NgylcsgipB566LD6OLJJtncaNJYP5MuUVwUcyi/qkpH0aLoyK47QdlZ1gjlik4
 xZ3/rROpb9Q9IZTu2fjyVWyeE6tyhsmNed2Ls+WA9kCvZhmodXJe9Zv40uvL1LaZl+ga MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xf74st8wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 18:20:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HIAn4F044940;
        Fri, 17 Jan 2020 18:20:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xjxm9c8je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 18:20:39 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00HIKa1L004175;
        Fri, 17 Jan 2020 18:20:36 GMT
Received: from [10.209.227.41] (/10.209.227.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 10:20:36 -0800
Subject: Re: [GIT_PULL] SOC: TI Keystone Ring Accelerator driver for v5.6
To:     Olof Johansson <olof@lixom.net>
Cc:     SoC Team <soc@kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
References: <1579205259-4845-1-git-send-email-santosh.shilimkar@oracle.com>
 <20200117000358.fe7ew4vvnz4yxbzj@localhost>
 <148b6ec3-6a8e-ced8-41b3-3dffd5528ed6@oracle.com>
 <CAOesGMiWL93ypL_4xqfqgwfVSOKtu8UqerzxV=Zr-aUkLp+rBw@mail.gmail.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <c938a1ec-4b82-ae88-8a98-27c4f6080db9@oracle.com>
Date:   Fri, 17 Jan 2020 10:20:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOesGMiWL93ypL_4xqfqgwfVSOKtu8UqerzxV=Zr-aUkLp+rBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/20 10:11 AM, Olof Johansson wrote:
> On Thu, Jan 16, 2020 at 9:05 PM <santosh.shilimkar@oracle.com> wrote:
>>
>> On 1/16/20 4:03 PM, Olof Johansson wrote:
>>> Hi,
>>>
>>> On Thu, Jan 16, 2020 at 12:07:39PM -0800, Santosh Shilimkar wrote:
>>>> Its bit late for pull request, but if possible, please pull it to
>>>> soc drivers tree.
>>>>
>>>> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
>>>>
>>>>     Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>     git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.6
>>>>
>>>> for you to fetch changes up to 3277e8aa2504d97e022ecb9777d784ac1a439d36:
>>>>
>>>>     soc: ti: k3: add navss ringacc driver (2020-01-15 10:07:27 -0800)
>>>>
>>>> ----------------------------------------------------------------
>>>> SOC: TI Keystone Ring Accelerator driver
>>>>
>>>> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
>>>> enable straightforward passing of work between a producer and a consumer.
>>>> There is one RINGACC module per NAVSS on TI AM65x SoCs.
>>>
>>> This driver doesn't seem to have exported symbols, and no in-kernel
>>> users. So how will it be used?
>>>
>>> Usually we ask to hold off until the consuming side/drivers are also ready.
>>>
>> The other patches getting merged via Vinod's tree. The combined series
>> is split into couple of series. Vinod is going to pull this branch
>> and apply rest of the patchset. And then couple of additional consumer
>> drivers will get posted.
> 
> Ok -- might have been useful to get that in the tag description for
> context. Something to consider next time.
> 
Sure. Will keep that in mind.

>>> Also, is there a reason this is under drivers/soc/ instead of somewhere more
>>> suitable in the drivers subsystem? It's not "soc glue code" in the same way as
>>> drivers/soc was intended originally.
>>>
>> These kind of SOC IP drivers, we put into drivers/soc/ because of lack
>> of specific subsystem where they fit in. Navigator was also similar example.
> 
> Hmm. At some point we'll have to push the brakes on this, since
> drivers/soc can't become a catch-all for random stuff like the old
> mach directories were. But it's tricky to tell just when -- sometimes
> you have to let the mess show up too.
> 
> I'll merge this when I do the next pass (today, likely).
> 
Thanks Olof !!
