Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7207C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A760B206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgDMITQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgDMITO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:19:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699F1C00860B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:19:14 -0700 (PDT)
IronPort-SDR: YHSj5ES432f/mAs2Hv5AV/UQCXPr0hiV3x2UDkpqiuWWuJFmCptnsccBjAcJwGqAlt2YZWiqAY
 Y2bTMahmft4A==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 01:19:13 -0700
IronPort-SDR: xpFBVXMksRbqrWtgafP/j1YD8Xl1CEayw09shA+pmV9XFahtg8PJsY1zlGl2KZulP08TdRm/sz
 zuIvbOYomwig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="txt'?scan'208";a="426619258"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.5.222]) ([10.238.5.222])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2020 01:19:11 -0700
Subject: Re: [LKP] [btrfs] 8d47a0d8f7: fio.write_bw_MBps -28.6% regression
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        kernel test robot <rong.a.chen@intel.com>,
        David Sterba <dsterba@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Leonard Lausen <leonard@lausen.nl>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
References: <20190513031733.GI31424@shao2-debian>
 <d82835ec-c99c-bb40-be9f-f49f8101e921@linux.intel.com>
 <a52f10f7-cdf6-9b00-9e49-b1344c17a190@suse.com>
 <20200410101406.GI5920@suse.cz>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <5816c503-e4d3-0b8b-4e89-a817d0b57851@linux.intel.com>
Date:   Mon, 13 Apr 2020 16:19:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200410101406.GI5920@suse.cz>
Content-Type: multipart/mixed;
 boundary="------------669AD32897F11BCD272E286F"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------669AD32897F11BCD272E286F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

This regression happened on "lkp-hsw-ep2", but “lkp-hsw-ep2” has been 
removed from the LKP tbox, so we retest the regression on another tbox 
“lkp-hsw-ep4”, their hardware is almost the same, "72 threads Intel(R) 
Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 256G memory". The test result is 
in the attached file compare.txt. The regression is -6.7% for v5.6, the 
origin regression is -8.9%, it is not serious as it test on 
"lkp-hsw-ep2" before.


On 4/10/2020 6:14 PM, David Sterba wrote:
> On Fri, Apr 10, 2020 at 02:44:55PM +0800, Qu Wenruo wrote:
>> On 2020/4/10 下午2:34, Xing Zhengjun wrote:
>>> Hi Wenruo,
>>>
>>>     We test it in v5.6, the issue still exist, do you have time to take a
>>> look at this? Thanks.
>>
>> This is expected.
>>
>> The extra check brings new overhead mostly equal to another CRC32 run.
>>
>> We believe it's worthy, as our read time tree checker has exposed quite
>> some bit flip corruption.
> 
> The test probably runs on a PMEM device so there's no slowdown from the
> actual IO and the in-memory checks are measurable, though 28% is a lot,
> I'd expect something like 5-10% at most.
> 

-- 
Zhengjun Xing

--------------669AD32897F11BCD272E286F
Content-Type: text/plain; charset=UTF-8;
 name="compare.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="compare.txt"

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KdGJveF9ncm91cC90ZXN0Y2Fz
ZS9yb290ZnMva2NvbmZpZy9jb21waWxlci9kZWJ1Zy1zZXR1cC9kaXNrL2ZzL3J1bnRpbWUv
bnJfdGFzay90aW1lX2Jhc2VkL3J3L2JzL2lvZW5naW5lL3Rlc3Rfc2l6ZS9jcHVmcmVxX2dv
dmVybm9yL3Vjb2RlOgogIGxrcC1oc3ctZXA0L2Zpby1iYXNpYy9kZWJpYW4teDg2XzY0LTIw
MTkxMTE0LmNnei94ODZfNjQtcmhlbC03LjYvZ2NjLTcvdGVzdC8ycG1lbS9idHJmcy8yMDBz
LzUwJS90Yi9yYW5kd3JpdGUvNGsvbGliYWlvLzEwMEcvcGVyZm9ybWFuY2UvMHg0MwoKY29t
bWl0OiAKICBmZjJhYzEwN2ZhZTI0NDBiNjg3N2M2MTVjMGFjNzg4ZDJhMTA2ZWQ3CiAgOGQ0
N2EwZDhmNzk0NzQyMmRkMzU5YWM4ZTQ2MjY4N2Y4MWE3YTEzNwogIHY1LjYKCmZmMmFjMTA3
ZmFlMjQ0MGIgOGQ0N2EwZDhmNzk0NzQyMmRkMzU5YWM4ZTQ2ICAgICAgICAgICAgICAgICAg
ICAgICAgdjUuNiAKLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIAogICAgICAgICAlc3RkZGV2ICAgICAl
Y2hhbmdlICAgICAgICAgJXN0ZGRldiAgICAgJWNoYW5nZSAgICAgICAgICVzdGRkZXYKICAg
ICAgICAgICAgIFwgICAgICAgICAgfCAgICAgICAgICAgICAgICBcICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgXCAgCiAgICAgIDAuNDQgwrEgIDclICAgICAgLTAuMSAgICAgICAgMC4z
MiDCsSAgNCUgICAgICAtMC4xICAgICAgICAwLjM2IMKxIDEwJSAgZmlvLmxhdGVuY3lfMTAw
MG1zJQogICAgICAwLjE2IMKxIDExJSAgICAgIC0wLjEgICAgICAgIDAuMDMgwrEgMjUlICAg
ICAgLTAuMSAgICAgICAgMC4wMiDCsSAgOCUgIGZpby5sYXRlbmN5XzEwMG1zJQogICAgICA1
LjU5IMKxICAzJSAgICAgIC0wLjAgICAgICAgIDUuNTkgwrEgIDklICAgICAgKzUuNyAgICAg
ICAxMS4yNiDCsSAxNSUgIGZpby5sYXRlbmN5XzEwbXMlCiAgICAgMzguMjUgICAgICAgICAg
ICArMS43ICAgICAgIDM5LjkyIMKxICAzJSAgICAgICs0LjcgICAgICAgNDIuOTcgICAgICAg
IGZpby5sYXRlbmN5XzIwbXMlCiAgICAgIDAuMjkgwrEgIDQlICAgICAgLTAuMSAgICAgICAg
MC4xNiDCsSAgMiUgICAgICAtMC4yICAgICAgICAwLjA2IMKxIDE0JSAgZmlvLmxhdGVuY3lf
MjUwbXMlCiAgICAgIDAuNTggwrEgMTclICAgICAgKzAuMSAgICAgICAgMC42NiDCsSAxMCUg
ICAgICAtMC41ICAgICAgICAwLjA4IMKxICA2JSAgZmlvLmxhdGVuY3lfMjUwdXMlCiAgICAg
IDAuMTcgwrEgNDMlICAgICAgKzAuMSAgICAgICAgMC4yNCDCsSAzNCUgICAgICArMC4yICAg
ICAgICAwLjQwIMKxIDMwJSAgZmlvLmxhdGVuY3lfMm1zJQogICAgIDQ0LjI0ICAgICAgICAg
ICAgLTQuMyAgICAgICAzOS45NSAgICAgICAgICAgIC00LjIgICAgICAgMzkuOTkgwrEgIDMl
ICBmaW8ubGF0ZW5jeV80bXMlCiAgICAgIDAuMDMgwrEgIDQlICAgICAgKzAuMiAgICAgICAg
MC4xOSDCsSAgMyUgICAgICArMC4xICAgICAgICAwLjE2IMKxIDEwJSAgZmlvLmxhdGVuY3lf
NTAwbXMlCiAgICAgIDguNTYgwrEgIDQlICAgICAgKzIuNyAgICAgICAxMS4zMCDCsSAgOCUg
ICAgICAtNi4yICAgICAgICAyLjM1IMKxICA1JSAgZmlvLmxhdGVuY3lfNTBtcyUKICAgICAg
MC4wMyDCsSAyNCUgICAgICArMC4yICAgICAgICAwLjI4ICAgICAgICAgICAgKzAuNCAgICAg
ICAgMC40NSDCsSAgMiUgIGZpby5sYXRlbmN5Xzc1MG1zJQogICAgICAwLjExIMKxIDM4JSAg
ICAgIC0wLjAgICAgICAgIDAuMTAgwrEgMzElICAgICAgKzAuMyAgICAgICAgMC40MSDCsSAz
MyUgIGZpby5sYXRlbmN5Xzc1MHVzJQogIDEzNjgyNzEzICAgICAgICAgICAgLTkuMCUgICAx
MjQ1NzExOCAgICAgICAgICAgIC02LjclICAgMTI3NjQ4MjcgICAgICAgIGZpby53b3JrbG9h
ZAogICAgMjY2LjM2ICAgICAgICAgICAgLTguOSUgICAgIDI0Mi43MCAgICAgICAgICAgIC02
LjUlICAgICAyNDguOTkgICAgICAgIGZpby53cml0ZV9id19NQnBzCiAgMTk5NjY2MzQgICAg
ICAgICAgICArMy4xJSAgIDIwNTc4MzA0ICAgICAgICAgICAgLTkuMiUgICAxODEzMTYyNiAg
ICAgICAgZmlvLndyaXRlX2NsYXRfOTAlX3VzCiAgMjE5NzY0MDUgICAgICAgICAgICArMy4y
JSAgIDIyNjc1NDU2ICAgICAgICAgICAtMTIuMyUgICAxOTI2NzU4NCAgICAgICAgZmlvLndy
aXRlX2NsYXRfOTUlX3VzCiAgOTI3OTg5NzYgwrEgIDUlICAgICsxMjQuMSUgICAyLjA4ZSsw
OCDCsSAgMyUgICAgKzM3NS4zJSAgNC40MTFlKzA4IMKxICAyJSAgZmlvLndyaXRlX2NsYXRf
OTklX3VzCiAgMTYzNTMzMDQgICAgICAgICAgICArOS43JSAgIDE3OTQyOTQyICAgICAgICAg
ICAgKzcuMCUgICAxNzUwMDc4OSAgICAgICAgZmlvLndyaXRlX2NsYXRfbWVhbl91cwogIDc2
ODI4NzMyICAgICAgICAgICAgKzAuNCUgICA3NzEzMjkxMSAgICAgICAgICAgICs2LjklICAg
ODIxMzU0MjQgwrEgIDIlICBmaW8ud3JpdGVfY2xhdF9zdGRkZXYKICAgICA2ODE4OCAgICAg
ICAgICAgIC04LjklICAgICAgNjIxMzEgICAgICAgICAgICAtNi41JSAgICAgIDYzNzQwICAg
ICAgICBmaW8ud3JpdGVfaW9wcwogICAgNTIzNDA2ICAgICAgICAgICAgKzkuNyUgICAgIDU3
NDQwMCAgICAgICAgICAgICs3LjAlICAgICA1NjAyNjAgICAgICAgIGZpby53cml0ZV9zbGF0
X21lYW5fdXMKICAxMzY0OTkxOSAgICAgICAgICAgIC0zLjglICAgMTMxMzM0NzEgICAgICAg
ICAgICArNy45JSAgIDE0NzI5NzAzICAgICAgICBmaW8ud3JpdGVfc2xhdF9zdGRkZXYKCg==
--------------669AD32897F11BCD272E286F--
