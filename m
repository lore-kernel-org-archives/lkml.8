Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA7C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0044F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="W5VNkyBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD0Vit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:38:49 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:17764 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbgD0Vis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:38:48 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 03RKsYBM032383;
        Mon, 27 Apr 2020 21:59:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=JhwQodLSD1Ep96VSsaFbBF1OgGARmW6/UR9tHM8q1z4=;
 b=W5VNkyBeFboJKQDkiCfZRSydf1+WxqhgeJpserbJU9MmoItnp6IzOBVKNea18+eFCGpu
 Pntuh32+jAJUVCZm5wBuG1NsMpTYXpiwerglBD9MJNNLIK8+/nI/wTV4wop3zfeeq4Zf
 CL8QA3ZYELQxSnRcENc5bVpG+Vjt80jUMDyPGR+87aGUvUN0aEZer1vhOUxQYtowqubV
 b14LupCrQylzC/rW6HixZjdAf1zWKuYj00i2TzC264zruBjjtNhxShK1HDxOOYcsFzgO
 X26qeusBRWuA8NGECvi7yYMHky6e1iFvNxIVFn/yEHBp2+Cxv6BojbiFkX9bhX+bP7DR FQ== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 30mcfqjkhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 21:59:56 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 03RKlX9k024953;
        Mon, 27 Apr 2020 16:59:55 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint2.akamai.com with ESMTP id 30mghw3v52-1;
        Mon, 27 Apr 2020 16:59:55 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 0BAE334728;
        Mon, 27 Apr 2020 20:59:55 +0000 (GMT)
Subject: Re: [PATCH v2] md/raid0: add config parameters to specify zone layout
To:     Song Liu <songliubraving@fb.com>
Cc:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "guoqing.jiang@cloud.ionos.com" <guoqing.jiang@cloud.ionos.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1585584045-11263-1-git-send-email-jbaron@akamai.com>
 <81A991E8-B87E-4518-9643-45037A104981@fb.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <694314ee-bd47-94a4-4c39-038a792a56fe@akamai.com>
Date:   Mon, 27 Apr 2020 16:59:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <81A991E8-B87E-4518-9643-45037A104981@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_16:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002250000 definitions=main-2004270170
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_16:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/20 7:22 PM, Song Liu wrote:
> 
> 
>> On Mar 30, 2020, at 9:00 AM, Jason Baron <jbaron@akamai.com> wrote:
>>
>> Let's add some CONFIG_* options to directly configure the raid0 layout
>> if you know in advance how your raid0 array was created. This can be
>> simpler than having to manage module or kernel command-line parameters.
>>
>> If the raid0 array was created by a pre-3.14 kernel, use
>> RAID0_ORIG_LAYOUT. If the raid0 array was created by a 3.14 or newer
>> kernel then select RAID0_ALT_MULTIZONE_LAYOUT. Otherwise, the default
>> setting is RAID0_LAYOUT_NONE, in which case the current behavior of
>> needing to specify a module parameter raid0.default_layout=1|2 is
>> preserved.
>>
>> Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> Cc: NeilBrown <neilb@suse.de>
>> Cc: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
> 
> This patch looks good. However, I am not sure whether the user will 
> recompile the kernel for a different default value. Do you have real
> world use case for this?
> 
> Thanks,
> Song
> 

Hi Song,

Yes, we knew that all our raid0 arrays were created with >=3.14
kernels, and thus we wanted a way to specify the new layout without
needing to add to the command line or a module parameter. For us,
maintaining a CONFIG_* option is just simpler.

Thanks,

-Jason
