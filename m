Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6611C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE89C20767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tg40sFNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgCTQeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:34:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46694 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgCTQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:34:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KGWwja015679;
        Fri, 20 Mar 2020 16:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lwCAdVvaGEe0Pa0FjqbKPwUgNu+L4ZQODXgeLN8IzFY=;
 b=tg40sFNc+kyRodTAQWHhGeCxLpb2Mwn/PVsF8Tm1FJveCRlKyJvN87h1qCfMX3+f3d0t
 cJNU0djEayhDRcgStz595iZNkojXsIgZf1qrRxHl5bySaOvYlaB4nCg6jgPWJJlyFo31
 VF9GiorqfWxoeTtlQhzsrSJ9BB8jKP9DrQeYC9ouT5Mu1R3DSgdIEwI85gfjEg7s+vos
 7oBsXcsmnwLie/4MQkR8bUwvD+1p1km5xnrNbY4oxT62XSP/TYXiACM6RY+2CB/DZaoS
 WN31HYWEKtvr4qthFWxozYh8eIyJ6bgJ98G14H/eNZGMpcJ+LFF+YNknDiRVh7mPa4up 1A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yrpprpq64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 16:34:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KGWp87007638;
        Fri, 20 Mar 2020 16:34:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ys8tydbxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 16:34:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02KGYDYl007993;
        Fri, 20 Mar 2020 16:34:13 GMT
Received: from [10.159.140.128] (/10.159.140.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Mar 2020 09:34:13 -0700
Subject: Re: [PATCH] docs: Prefer 'python3' when building htmldocs
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1584658842-778-1-git-send-email-victor.erminpour@oracle.com>
 <20200320121505.579fb6cc@coco.lan>
From:   Victor Erminpour <victor.erminpour@oracle.com>
Organization: Oracle America
Message-ID: <a9961edf-e655-4ee0-163a-01907f7ac634@oracle.com>
Date:   Fri, 20 Mar 2020 09:33:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320121505.579fb6cc@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9566 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/20 4:15 AM, Mauro Carvalho Chehab wrote:
> Em Thu, 19 Mar 2020 16:00:42 -0700
> Victor Erminpour <victor.erminpour@oracle.com> escreveu:
> 
>> Prefer 'python3' and 'sphinx-build-3' when building htmldocs.
>> Building htmldocs fails on systems that don't have 'python'
>> and 'sphinx-build' installed, but do have 'python3' and
>> 'sphinx-build-3' available.
>>
>> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
>> ---
>>   Documentation/Makefile | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index d77bb607aea4..00c400523e15 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -11,6 +11,7 @@ endif
>>   
>>   # You can set these variables from the command line.
>>   SPHINXBUILD   = sphinx-build
>> +SPHINXBUILD3  = sphinx-build-3
> 
> This will very likely break on some distros. For example, Fedora 31 with a
> venv configured environment won't have a "sphinx-build-3" program.
>

Hi Mauro,

Fair enough, I've noticed that some distros provide a symlink from
sphinx-build to sphinx-build-3, but it's not guaranteed for every
distro (if they have python3 at all).


> I have already a patchset addressing this. I'm testing it on several
> different distros and versions.
> 
> My plan is to submit the patch series for it after the merge window. If you
> want to do a sneak pick, there's a version of the patch series on my
> experimental tree (probably not the latest version):
> 
> 	https://urldefense.com/v3/__https://git.linuxtv.org/mchehab/experimental.git/log/?h=random_doc_fixes__;!!GqivPVa7Brio!NJwqcbN8vCCZcaL8CGkgL27pxL0x4qCMpoQm6riFdb0Jo9_KuD6vROdjw_4owcdvncvO$
> 

Valeu, aquele abraço!

--Victor


> 
>>   SPHINXOPTS    =
>>   SPHINXDIRS    = .
>>   _SPHINXDIRS   = $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst))
>> @@ -61,11 +62,23 @@ loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
>>   # $5 reST source folder relative to $(srctree)/$(src),
>>   #    e.g. "media" for the linux-tv book-set at ./Documentation/media
>>   
>> +HAVE_PYTHON3 := $(shell if which $(PYTHON3) >/dev/null 2>&1; then echo 1; else echo 0; fi)
>> +HAVE_SPHINX3 := $(shell if which $(SPHINXBUILD3) >/dev/null 2>&1; then echo 1; else echo 0; fi)
>> +PYTHON_BIN = $(PYTHON)
>> +
>> +# If we have both python3 and sphinx-build-3,
>> +# prefer python3 over python.
>> +ifeq ($(HAVE_PYTHON3),1)
>> +    ifeq ($(HAVE_SPHINX3),1)
>> +        PYTHON_BIN = $(PYTHON3)
>> +    endif
>> +endif
>> +
>>   quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>>         cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/media $2 && \
>>   	PYTHONDONTWRITEBYTECODE=1 \
>>   	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
>> -	$(PYTHON) $(srctree)/scripts/jobserver-exec \
>> +	$(PYTHON_BIN) $(srctree)/scripts/jobserver-exec \
>>   	$(SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
>>   	$(SPHINXBUILD) \
>>   	-b $2 \
> 
> 
> 
> Thanks,
> Mauro
> 

-- 
Victor Hugo Erminpour
Principal Member of Technical Staff
Oracle America
