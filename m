Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B331EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E73821744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="bvvNyOS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHEGuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:50:32 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:49006 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgHEGub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j6bOMQTOJGyCFMqmeJTZ9A3xBlSi0N9lvgZBWhWfuCg=; b=bvvNyOS+9jTv07NUaUzJ0ZTOc/
        nq6N5GRNJMvdCDj64aGVpMrQmeGPKFu0kOaSJPlrH9KJb4ubUz6UeeHXHFSntRL874m5TxqQqQC3+
        BOJGx4JYuTwia3KZwS4mUJufzcoTkqewK9AiAN9v3N9N9+08w3ip2BtBSS+t9q0+W99E=;
Received: from lmontsouris-657-1-153-95.w82-127.abo.wanadoo.fr ([82.127.191.95] helo=[192.168.1.116])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1k3DFo-0005T3-Ny; Wed, 05 Aug 2020 01:50:26 -0500
Subject: Re: [PATCH v2 2/3] perf symbols: Try reading the symbol table with
 libbfd
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
References: <20200804085736.385232-1-rbernon@codeweavers.com>
 <20200804085736.385232-2-rbernon@codeweavers.com>
 <20200804203249.GJ139381@krava>
From:   Remi Bernon <rbernon@codeweavers.com>
Message-ID: <48dcbc10-8a68-0979-a00b-c8b3592b1924@codeweavers.com>
Date:   Wed, 5 Aug 2020 08:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200804203249.GJ139381@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-04 22:32, Jiri Olsa wrote:
> On Tue, Aug 04, 2020 at 10:57:35AM +0200, Remi Bernon wrote:
> 
> SNIP
> 
>> +
>> +int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>> +{
>> +	int err = -1;
>> +	long symbols_size, symbols_count;
>> +	asection *section;
>> +	asymbol **symbols, *sym;
>> +	struct symbol *symbol;
>> +	bfd *abfd;
>> +	u_int i;
>> +	u64 start, len;
>> +
>> +	abfd = bfd_openr(dso->long_name, NULL);
>> +	if (!abfd)
>> +		return -1;
>> +
>> +	if (!bfd_check_format(abfd, bfd_object)) {
>> +		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
>> +			  dso->long_name);
>> +		goto out_close;
>> +	}
>> +
>> +	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
>> +		goto out_close;
> 
> aah, so the code is actualy only for non elf objects,
> somehow I thought it's replacing the symbol load globaly
> 
> jirka
> 

Maybe it could but because libbfd exposes the common subset of all its 
backends, it doesn't provide symbol sizes for instance (that's how I 
understand it). So I didn't want to lose features compared to what the 
libelf path is currently doing.

For non-elf objects, the implementation here works around that by 
assuming that all the symbols are following each other contiguously, but 
that's a little bit incorrect.
-- 
Rémi Bernon <rbernon@codeweavers.com>
