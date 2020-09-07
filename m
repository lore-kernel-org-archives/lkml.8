Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47595C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034DB2078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jGdeKhYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgIGJ2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:28:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:51584 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgIGJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:28:45 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200907092842epoutp03ead383e77c88603fc2c3a6a60926ddff~ydlRo8yxs2514925149epoutp03f
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:28:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200907092842epoutp03ead383e77c88603fc2c3a6a60926ddff~ydlRo8yxs2514925149epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599470922;
        bh=euIFRKlzktfcNfP6APdah/1qbUW1A2GhWZe1u2dI+Vg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jGdeKhYExeggttdhVofnyf7IG2JIlsHaggwhgvpPaLpzZ8iS1KjpkPzxvR96/NQKh
         OvNGSFMeKwwMUnRSFbMUDorQ7fNd7FuEmixtd9cvoez3V+7sQu3kwPvESIH7xZiISj
         fLQEIR4yMLRis230McnEVPaznHmEMREKKI6o16lU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200907092841epcas2p2547b41fab2974922d1978b15d6b3ec2e~ydlRFTZxt1833618336epcas2p2h;
        Mon,  7 Sep 2020 09:28:41 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.188]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BlNJ768TJzMqYkj; Mon,  7 Sep
        2020 09:28:39 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.11.18874.64DF55F5; Mon,  7 Sep 2020 18:28:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200907092837epcas2p2eabe2595be0ab95094486801bfc02021~ydlNCZp1Y1833618336epcas2p2e;
        Mon,  7 Sep 2020 09:28:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200907092837epsmtrp2c0c539bed1b9d8d5d65a14d926115950~ydlNBjxu83271232712epsmtrp2A;
        Mon,  7 Sep 2020 09:28:37 +0000 (GMT)
X-AuditID: b6c32a46-503ff700000049ba-5e-5f55fd468653
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.60.08382.54DF55F5; Mon,  7 Sep 2020 18:28:37 +0900 (KST)
Received: from KORDD001994 (unknown [12.36.185.71]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200907092837epsmtip1bdeca11e5b153c5fa74ec78ccbb977a4~ydlM1GefD0392603926epsmtip1b;
        Mon,  7 Sep 2020 09:28:37 +0000 (GMT)
From:   =?ks_c_5601-1987?B?sejDorHi?= <changki.kim@samsung.com>
To:     "'John Ogness'" <john.ogness@linutronix.de>,
        "'Petr Mladek'" <pmladek@suse.com>
Cc:     <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <changbin.du@intel.com>, <masahiroy@kernel.org>,
        <rd.dunlap@gmail.com>, <gregkh@linuxfoundation.org>,
        <krzk@kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <87ft7xazsf.fsf@jogness.linutronix.de>
Subject: RE: printk: Add process name information to printk() output.
Date:   Mon, 7 Sep 2020 18:28:37 +0900
Message-ID: <008801d684f9$43e1c140$cba543c0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMW8ccY1/AbwLmEvIpBmAjIk1luugFhZewlAYutcjUCcGf6+QJbuaAIAvKB89oBKHDedqZ9OctQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmua7b39B4gz9v+Cw2XjzOZNG8eD2b
        xbYr8xktzp/fwG5xedccNouHD26wWvx//JXV4sXmTlaLfR0PmCzWfn7M7sDlsXPWXXaPln23
        2D0W73nJ5LFpVSebx7tz59g99s9dw+6xfstVFo/Pm+QCOKJybDJSE1NSixRS85LzUzLz0m2V
        vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAjlRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
        5BeX2CqlFqTkFBgaFugVJ+YWl+al6yXn51oZGhgYmQJVJuRk7Fk5lbVgh2bFtNlXmRsYOxS6
        GDk5JARMJP7MXMzexcjFISSwg1Fi2uTdjBDOJ0aJzs5FjCBVQgLfGCUurUiA6bg2/RtU0V5G
        iaMX1jFDOC8YJVbMWMwCUsUmYCvR3vmAHcQWEQiVOPVnBlgHs8ANRonNq6+ygSQ4BYwlGvZP
        BCsSFnCVeH3yHZjNIqAicf9GG1ADBwevgKXEnWmBIGFeAUGJkzOfgM1nFjCSWLJ6PhOELS+x
        /e0cZojrFCR+Pl3GCrE3SuLgrwZ2iBoRidmdbWCHSggc4ZBofXCQHaLBRWLdn41QtrDEq+Nb
        oGwpic/v9rJB2PUS3/oXsEA09zBK/O06DpUwlpj1rB3sUAkBZYkjt6CO45PoOPyXHSLMK9HR
        JgRhqkp0T9aHMKUlPuywmcCoNAvJY7OQPDYLyWOzkDywgJFlFaNYakFxbnpqsVGBEXJkb2IE
        J2Attx2MU95+0DvEyMTBeIhRgoNZSYS361BovBBvSmJlVWpRfnxRaU5q8SFGU2BQT2SWEk3O
        B+aAvJJ4Q1MjMzMDS1MLUzMjCyVx3nrFC3FCAumJJanZqakFqUUwfUwcnFINTN4rxBYwaNk4
        30ucOPVYZE/1thif5fk9m5YveDRVQWjBu301dXwr1TbU3zrAYHN+esO23uwbEQ/eLL1o5CHJ
        dSKp7EZyrkRF5LqyeZWcpTZ+CUfmKB5aosmg3DtJ4cdtxcrULqEyV6+GfJEdaWKPe25oLE3/
        cWV1a9Zxn/tRS4w7hYxlFyao1Qe4zeJZfLlps1fn4tY03pC2K0yhM8WnLp6RGiX/Y3JMcsN5
        hf77POptPUnx2QFHmmYstjj6RTVzd2dkd1+4kmdkrXVaeF/03frS0JsWVdvuX8q7Ubr+KTuj
        r6uPskRAxvsfJ/3n6x9N3MWo6SEjs7p7SfDEkrPdeQcfrJhVVvPR4NDSm8FKLMUZiYZazEXF
        iQAr7RBESQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSnK7r39B4g4VrFSw2XjzOZNG8eD2b
        xbYr8xktzp/fwG5xedccNouHD26wWvx//JXV4sXmTlaLfR0PmCzWfn7M7sDlsXPWXXaPln23
        2D0W73nJ5LFpVSebx7tz59g99s9dw+6xfstVFo/Pm+QCOKK4bFJSczLLUov07RK4MvasnMpa
        sEOzYtrsq8wNjB0KXYycHBICJhLXpn9j7GLk4hAS2M0ocf/5FmaIhLTE8Vez2SFsYYn7LUdY
        IYqeMUp8m9XGCpJgE7CVaO98AFYkIhAqcW79EXaQImaBB4wS9168ZYHoOMgkcfHJeiaQKk4B
        Y4mG/RPBOoQFXCVen3wHZrMIqEjcv9EGdAcHB6+ApcSdaYEgYV4BQYmTM5+wgNjMQKc2Hu6G
        suUltr+dA3WpgsTPp8tYIY6Ikjj4q4EdokZEYnZnG/MERuFZSEbNQjJqFpJRs5C0LGBkWcUo
        mVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyNWpo7GLev+qB3iJGJg/EQowQHs5IIb9eh
        0Hgh3pTEyqrUovz4otKc1OJDjNIcLErivDcKF8YJCaQnlqRmp6YWpBbBZJk4OKUamDos/L+L
        nozmmXrnjeLG5qX3u89fPLnFbULln/3RSUfz1U+fFw6YmLP32PGOd5Min8sFLf143fjocQ5V
        RXXb9t5jqicu6Ik9u/FHJsDBQYdJ4NyRGXOYDFbsXGpUfDxV2C352qLLC0yd53buy1ge+8fX
        oOrn0s4ZR0KTlh/SPmY7N9JQKeHbTvmpb03dH/gfZJaqYmTgYdxUej50jlwBB6OW6pf6/WmW
        onM4z0UvWWf7/96G3ayZ6ySLnvHLVfBa/JLoszXxlVY+WOdTt9N4Zuv51Z8jbFsvlboz7tdj
        932sJxZ2c6LSXMUYA9fgs6oJy6/6aPT4F2eFbw/ddNcn7mqM8ZdAEQ7D3nrZ6c/4lViKMxIN
        tZiLihMB6FepsDUDAAA=
X-CMS-MailID: 20200907092837epcas2p2eabe2595be0ab95094486801bfc02021
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200904082449epcas2p4420d5df2083325b328a182c79f5c0948
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
        <20200904082438.20707-1-changki.kim@samsung.com>
        <874kod6fgh.fsf@jogness.linutronix.de> <20200904124530.GB20558@alley>
        <87y2lp4r6o.fsf@jogness.linutronix.de> <20200904151336.GC20558@alley>
        <87ft7xazsf.fsf@jogness.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2020-09-04, Petr Mladek <pmladek@suse.com> wrote:
> >>> I am currently playing with support for all three timestamps based
> >>> on
> >>> https://lore.kernel.org/lkml/20200814101933.574326079@linutronix.de/
> >>>
> >>> And I got the following idea:
> >>>
> >>> 1. Storing side:
> >>>
> >>>    Create one more ring/array for storing the optional metadata.
> >>>    It might eventually replace dict ring, see below.
> >>>
> >>>    struct struct printk_ext_info {
> >>> 	u64 ts_boot;			/* timestamp from boot clock */
> >>> 	u64 ts_real;			/* timestamp from real clock */
> >>> 	char process[TASK_COMM_LEN];	/* process name */
> >>>    };
> >>>
> >>>    It must be in a separate array so that struct prb_desc stay stable
> >>>    and crashdump tools do not need to be updated so often.
> >>>
> >>>    But the number of these structures must be the same as descriptors.
> >>>    So it might be:
> >>>
> >>>    struct prb_desc_ring {
> >>> 	unsigned int		count_bits;
> >>> 	struct prb_desc		*descs;
> >>> 	struct printk_ext_info  *ext_info
> >>> 	atomic_long_t		head_id;
> >>> 	atomic_long_t		tail_id;
> >>>    };
> >>>
> >>>    One huge advantage is that these extra information would not block
> >>>    pushing lockless printk buffer upstream.
> >>>
> >>>    It might be even possible to get rid of dict ring and just
> >>>    add two more elements into struct printk_ext_info:
> >>>
> >>> 	  char subsystem[16];	/* for SUBSYSTEM= dict value */
> >>> 	  char device[48];	/* for DEVICE= dict value */
> >
> > From my POV, if we support 3 timestamps then they must be stored
> > reliably. And dict ring is out of the game.
> 
> Agreed. I am just trying to think of how to better manage the strings,
> which currently are rare and optional. That is where the dict_ring becomes
> interesting.
> 
> Perhaps we should use both the fixed structs with the variable dict_ring.
> printk_ext_info could look like this:
> 
> struct struct printk_ext_info {
>     u64 ts_boot;
>     u64 ts_real;
>     char *process;
>     char *subsystem;
>     char *device;
> };
> 
> And @process, @subsystem, @device could all point to null-terminated
> trings within the dict_ring. So printk.c code looks something like this:
> 
> size_t process_sz = strlen(process) + 1; size_t subsystem_sz =
> strlen(subsystem) + 1; size_t device_sz = strlen(device) + 1; struct
> prb_reserved_entry e; struct printk_record r; char *p;
> 
> prb_rec_init_wr(&r, text_len, process_sz + subsystem_sz + device_sz);
> prb_reserve(&e, prb, &r);
> 
> memcpy(r.text_buf, text, text_len);
> r.info->text_len = text_len;
> 
> /* guaranteed ext data */
> r.ext_info->ts_boot = time_boot();
> r.ext_info->ts_real = time_real();
> 
> /* optional ext data */
> if (r.dict_buf) {
>     p = r.dict_buf;
> 
>     memcpy(p, process, process_sz);
>     r.ext_info->process = p;
>     p += process_sz;
> 
>     memcpy(p, subsystem, subsystem_sz);
>     r.ext_info->subsystem = p;
>     p += subsystem_sz;
> 
>     memcpy(p, device, device_sz);
>     r.ext_info->device = p;
> 
>     r.info->dict_len = process_sz + subsystem_sz + device_sz; }
> 
> > And I am not comfortable even with the current dictionary handling.
> > I already wrote this somewhere. The following command is supposed to
> > show all kernel messages printed by "pci" subsystem:
> >
> > 	$> journalctl _KERNEL_SUBSYSTEM=pci
> >
> > It will be incomplete when the dictionary metadata were not saved.
> 
> In that case, perhaps @subsystem should be a static array in
> printk_ext_info instead.
> 
> > Regarding the waste of space. The dict ring currently has the same
> > size as the text ring. It is likely a waste of space as well. Any
> > tuning is complicated because it depends on the use case.
> 
> The whole point of the dict_ring is that it allows for variable length
> _optional_ data to be stored. If we decide there is no optional data, then
> dict_ring is not needed.
> 
> > The advantage of the fixed @ext_info[] array is that everything is
> > clear, simple, and predictable (taken space and name length limits).
> > We could easily tell users what they will get for a given cost.
> 
> Agreed. For non-optional data (such as your timestamps), I am in full
> agreement that a fixed array is the way to go. And it would only require a
> couple lines of code added to the ringbuffer.
> 
> My concern is if we need to guarantee space for all possible dictionary
> data of all records. I think the dict_ring can be very helpful here.
> 
> John Ogness

To be honest, This patch is made based on kernel 5.4.
So I haven't fully figured out the printk ring buffer yet.
When I see the code, dict_buf didn't print out into prefix. Right?
I want to print out the information into prefix.

When I developed the kernel in Android,
we could modify prefix of kernel log format. Because we should be able to
obtain a lot of information with just a kernel log.
But now, we can't modify the prefix due to GKI. So We need a printk where
we can freely modify the prefix.
The prefix doesn't need to be saved to log_buf. It only needs to be printed
out.

It would be great if printk.format is possible.

printk.format=ts,cpu,comm,pid,in_atomic

Changki Kim.

