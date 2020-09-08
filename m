Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47052C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3C0206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="b2C//Off"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgIHQ3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:29:41 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:9328 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731400AbgIHQX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:23:58 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088GHDht029520;
        Tue, 8 Sep 2020 16:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=zVoU7ZsW2BmeyEMF9O139z2LNkJfxiCWxikqKicR6wA=;
 b=b2C//Off5OJSLlbWx61JTGg4U0gQ+0NyNJr9n8jOinl01JCQZg5XbTo0EkIQSQIyPsCf
 AVNXmay4P5hOX4FeS+8m4tlfdxG/5+nP96iKYTOkLn/ai4uejlMsX94/RyD+eeMkfWlJ
 xd4g3ivcZaLpKZPpNUzhdC1HtBFYsqvEqFNKFDpfWuwiBGCxbHuTP2nd7ppNPJ3nKIhm
 ZMecYpcxS9qrt52UPKavJ44T+aEb3t3dOJ0CxVhj0j7gCtyU97zktGDHb1AK9VgjL1n+
 BLDLuUBGm6nq0ja+au/LPgv387v25VRZaO67ktGz4/pAQTkjgV4LT8hjnnYqmxZHQvp3 pw== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 33c1nntahy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 16:23:46 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id BFFC69D;
        Tue,  8 Sep 2020 16:23:45 +0000 (UTC)
Received: from [16.99.146.51] (unknown [16.99.146.51])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 576054F;
        Tue,  8 Sep 2020 16:23:43 +0000 (UTC)
Subject: Re: [PATCH 00/12] x86/platform/uv: Updates for UV5
To:     peterz@infradead.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20200907185430.363197758@hpe.com>
 <20200908152014.GB4114051@kroah.com>
 <03de6a71-5fc1-98f5-3886-536c72b2761d@hpe.com>
 <20200908154700.GW1362448@hirez.programming.kicks-ass.net>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <a29405b1-abfc-b7ef-23fb-b29b3dc07255@hpe.com>
Date:   Tue, 8 Sep 2020 09:23:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200908154700.GW1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_08:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=596 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=1 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009080155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2020 8:47 AM, peterz@infradead.org wrote:
> On Tue, Sep 08, 2020 at 08:28:16AM -0700, Mike Travis wrote:
>> I didn't.  If I could figure out how to convert quilt patches into git
>> commits I might be able to do that?  (And I didn't know that diffstats were
>> needed on the into?)
> 
> $ git quiltimport
> 
> Or, for the more enterprising person:
> 
> $ quilt series | while read file; do git am $file; done
> 
> Generating a diffstat from a quilt series (when applied):
> 
> $ quilt diff --combine - | diffstat
> 

Cool, thanks.  I am doing this for the V2 version of the patches.  Most 
will get touched anyways because of the Copyright thing.
