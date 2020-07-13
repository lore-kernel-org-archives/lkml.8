Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92126C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B682067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgGMIY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:24:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:49516 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMIY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:24:57 -0400
IronPort-SDR: yiOlnoNwbvbLeFPt9Z6AKLRL+63r7ZWSM5F8uIwQZqgSs3Ts5dtuopuuW4xIZDtvTEDNnFuYnw
 y8PduKqy1rUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146057365"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="146057365"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 01:24:57 -0700
IronPort-SDR: ivpD031Syyq6sRNRFaDb99m6vvcZZ25rrVtrbeH2JPwBnwok9C3l+mwbkn6Ix6wCpUfxOLZV9B
 US7A02fhl3Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="269656686"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2020 01:24:57 -0700
Received: from [10.249.229.49] (abudanko-mobl.ccr.corp.intel.com [10.249.229.49])
        by linux.intel.com (Postfix) with ESMTP id 4245758080E;
        Mon, 13 Jul 2020 01:24:55 -0700 (PDT)
Subject: Re: [PATCH v10 05/15] perf evlist: implement control command handling
 functions
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
 <93e1c3b1-ee77-a94d-8806-049e0245fab7@linux.intel.com>
 <CAM9d7cikDcaLaUv8+xh9fp_KVHFVQD+eRYGAR5kN4A7ppPHmBQ@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <218d3cf9-86fc-44ac-89eb-4b7ad422deb8@linux.intel.com>
Date:   Mon, 13 Jul 2020 11:24:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cikDcaLaUv8+xh9fp_KVHFVQD+eRYGAR5kN4A7ppPHmBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.07.2020 6:20, Namhyung Kim wrote:
> On Wed, Jul 8, 2020 at 4:50 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> Implement functions of initialization, finalization and processing
>> of control command messages coming from control file descriptors.
>> Allocate control file descriptor as descriptor at struct pollfd
>> object of evsel_list for atomic poll() operation.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
> [SNIP]
>> +static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
>> +                             char *cmd_data, size_t data_size)
>> +{
>> +       int err;
>> +       char c;
>> +       size_t bytes_read = 0;
>> +
>> +       memset(cmd_data, 0, data_size--);
> 
> I overlooked the '--' at the end and thought there might be
> buffer overflow..  Care to add a comment?

If it wants to be more explicit then it could possibly be implemented
like this:

memset(cmd_data, 0, data_size);
data_size--;

> 
>> +
>> +       do {
>> +               err = read(evlist->ctl_fd.fd, &c, 1);
> 
> Maybe I missed earlier discussion, but do we really want
> this 1 byte read in a loop?

That was the explicit request to support commands of variable
length so it implements it like that.

Alexei

> 
> Thanks
> Namhyung
> 
> 
>> +               if (err > 0) {
>> +                       if (c == '\n' || c == '\0')
>> +                               break;
>> +                       cmd_data[bytes_read++] = c;
>> +                       if (bytes_read == data_size)
>> +                               break;
>> +               } else {
>> +                       if (err == -1)
>> +                               pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
>> +                       break;
>> +               }
>> +       } while (1);
>> +
>> +       pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
>> +                bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
>> +
>> +       if (err > 0) {
>> +               if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
>> +                            (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
>> +                       *cmd = EVLIST_CTL_CMD_ENABLE;
>> +               } else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
>> +                                   (sizeof(EVLIST_CTL_CMD_DISABLE_TAG)-1))) {
>> +                       *cmd = EVLIST_CTL_CMD_DISABLE;
>> +               }
>> +       }
>> +
>> +       return err;
>> +}
