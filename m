Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C2A2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ErWRNWuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404126AbgFSQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392921AbgFSQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:10:17 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1EC06174E;
        Fri, 19 Jun 2020 09:10:17 -0700 (PDT)
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JG2QZa021248;
        Fri, 19 Jun 2020 17:07:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=7CxRloMUzMzHtMYCAIVGIDg2K8kW9NS7Ez3DjXqAktk=;
 b=ErWRNWuZtlY60K2Le5us949BReegtvr7yjcy84NTOJPVRJ/s0ap065bNIvCItRkefDNG
 F4RVJ/PR/ZGPa06n/h+eeIzg9MVN3Bd8rZdhA3TEe2QqE+MAf4hJmYTevF0dcQpljAUt
 diHMpTzK/GzZlA7EclyixCNnPJ89oEQ+C6rBgystmYM2exlZFlA+G3o6fLnhNxs+RzUC
 0Ulhuwch+yr1M2Q5dlWpsYCTJfSfKDv91f+LSVJxmZVQeFZFu6rh8IfU9biM9Rkiagxj
 Sn7gYn1j3wzhyzP7El+TgZowv9WXe2BLfLad9ldYTFcB4V2Mxh0O/cCM72tGdRx2zU3d BA== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 31qrebsgw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 17:07:54 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 05JG5VvO011524;
        Fri, 19 Jun 2020 12:07:54 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com with ESMTP id 31qjmbvqx3-1;
        Fri, 19 Jun 2020 12:07:54 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id AE3853A60B;
        Fri, 19 Jun 2020 16:07:53 +0000 (GMT)
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
To:     jim.cromie@gmail.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Joe Perches <joe@perches.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
 <20200617162536.611386-23-jim.cromie@gmail.com> <20200618161912.GD3617@alley>
 <20200618174058.GE3617@alley>
 <746984fb-00ee-9079-efac-50167f3c3e40@akamai.com>
 <CAJfuBxwLKDSx6RA_ZOk=eEHw0P3FeAcT=PCr-aHjUFKDS2p8cQ@mail.gmail.com>
 <172c0580-279f-aa3e-817a-4216067bea10@akamai.com>
 <23396523-28c3-74e6-3e62-be68e5a5465a@linaro.org>
 <CAJfuBxx2KDBLX9H6N-79VPOXBwbdzSQse41azTCk0SZs7PtQuA@mail.gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <f61b184b-054e-4dd1-04e0-9d045265d9e0@akamai.com>
Date:   Fri, 19 Jun 2020 12:07:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfuBxx2KDBLX9H6N-79VPOXBwbdzSQse41azTCk0SZs7PtQuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_16:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190118
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_16:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 cotscore=-2147483648 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/20 6:48 PM, jim.cromie@gmail.com wrote:
> On Thu, Jun 18, 2020 at 4:34 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi Jason, Jim,
>>
> 
> 
> 
>>> I would be curious to see what Stanimir thinks of this proposal
>>> and whether it would work for his venus driver, which is what
>>> prompted this module group discussion.
>>
>> Hmm, we spin in a circle :)
>>
>> Infact this was my first way of implementing the groups in Venus driver,
>> you can see it at [1].
>>
>>  +#define VDBGL(fmt, args...)   pr_debug("VENUSL: " fmt, ##args)
>>  +#define VDBGM(fmt, args...)   pr_debug("VENUSM: " fmt, ##args)
>>  +#define VDBGH(fmt, args...)   pr_debug("VENUSH: " fmt, ##args)
>>  +#define VDBGFW(fmt, args...)  pr_debug("VENUSFW: " fmt, ##args)
>>
> 
> I recall :-)
> 
> I think Greg K-Hs   distaste for those defines was for using them,
> as it tosses the utility of grep pr_debug
> 
> pr_debug("VENUSM:"
> is barely longer than
> VDBGM
> 
> with ddebug_exec_queries, you can leverage the existing format.
> 
>>

Ok, yes, I like this approach because its simple (just exports
ddebug_exec_queries()), and it seems to be quite flexible. Module
authors can 'tag' their queries any way they want.

We could provide some structure, if desired, something like:

#define DYNAMIC_DEBUG_LOW "-V "
#define DYNAMIC_DEBUG_MED "-VV "
#define DYNAMIC_DEBUG_HIGH "-VVV "
#define DYNAMIC_DEBUG_REALLY_HIGH "-VVVV "

And then these could be added to the pr_debug() so:

#define VDBGL(fmt, args...)   pr_debug("VENUSL: "  DYNAMIC_DEBUG_LOW fmt, ##args)
or
#define VDBGL(fmt, args...)   pr_debug(DYNAMIC_DEBUG_LOW fmt, ##args)
or just:
pr_debug(DYNAMIC_DEBUG_LOW "ERROR HERE: %d", err)

Thanks,

-Jason


>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2020_5_21_668&d=DwIBaQ&c=96ZbZZcaMF4w0F4jpN6LZg&r=1fLh1mlLqbfetnnGsbwXfpwmGlG4m83mXgtV4vZ1B1A&m=29UzIGELhVL1znJsgyjGDKGIEdSkSlCsmAh0jpbWHVQ&s=_szr6DQOsbdQ-oYCR9-fs4b-XG_fotTiObUfG3z6UtY&e= 
>>
>> --
>> regards,
>> Stan
> 
> thanks
> Jim
> 
