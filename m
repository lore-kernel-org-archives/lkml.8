Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BAE2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="cVLpDa3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390492AbgFXNlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:41:05 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:58028 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbgFXNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rwlNhj+FV4122iecCtBkSkXK/PmNPWez1oTxJTG12WM=; b=cVLpDa3mE5IaWrzueqGGMA4Ub1
        SE4lBdrtCrJDK/lPEfTg+vq9kgQM404IanoHEuYhWy94WB4I26SsHLNYv0G79/6UAVabWFX/L9f+J
        C3J4oxkDo9AmwJ39TxvdENr47WqeAFLS5gP0J6L8XkqDM8+ubEW2JbMis7+hRVNP35dk=;
Received: from lfbn-mar-1-578-97.w109-208.abo.wanadoo.fr ([109.208.124.97] helo=[192.168.1.16])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1jo5e7-0004r3-7C; Wed, 24 Jun 2020 08:41:00 -0500
Subject: Re: [PATCH 2/3] perf symbols: Try reading the symbol table with
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
References: <20200624103041.825746-1-rbernon@codeweavers.com>
 <20200624103041.825746-2-rbernon@codeweavers.com>
 <20200624132545.GD2719003@krava>
From:   =?UTF-8?Q?R=c3=a9mi_Bernon?= <rbernon@codeweavers.com>
Message-ID: <8e8e5b2d-63e3-9feb-a21a-6bf355ce4013@codeweavers.com>
Date:   Wed, 24 Jun 2020 15:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200624132545.GD2719003@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 15:25, Jiri Olsa wrote:
> On Wed, Jun 24, 2020 at 12:30:40PM +0200, Remi Bernon wrote:
> 
> SNIP
> 
>> +
>> +		symbols__insert(&dso->symbols, symbol);
>> +	}
>> +#ifdef bfd_get_section
>> +#undef bfd_asymbol_section
>> +#endif
>> +
>> +	symbols__fixup_end(&dso->symbols);
>> +	symbols__fixup_duplicate(&dso->symbols);
>> +	dso->adjust_symbols = 1;
>> +
>> +	err = 0;
>> +out_free:
>> +	free(symbols);
>> +out_close:
>> +	bfd_close(abfd);
>> +	return err;
>> +}
>> +#endif
>> +
>>   static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
>>   					   enum dso_binary_type type)
>>   {
>> @@ -1695,6 +1816,7 @@ int dso__load(struct dso *dso, struct map *map)
>>   		bool next_slot = false;
>>   		bool is_reg;
>>   		bool nsexit;
>> +		int bfdrc = -1;
>>   		int sirc = -1;
>>   
>>   		enum dso_binary_type symtab_type = binary_type_symtab[i];
>> @@ -1713,12 +1835,19 @@ int dso__load(struct dso *dso, struct map *map)
>>   			nsinfo__mountns_exit(&nsc);
>>   
>>   		is_reg = is_regular_file(name);
>> +#ifdef HAVE_LIBBFD_SUPPORT
>>   		if (is_reg)
>> +			bfdrc = dso__load_bfd_symbols(dso, name);
>> +#endif
> 
> so the comment says that we try bfd when the libelf fails,
> but the code seems to do the oposite.. starts with bfd
> and skip libelf if it's ok
> 
> jirka
> 

Ah, sorry I forgot to reword the commit comment to match the changes, 
thanks for noticing. It should probably be something like that:

   Trying to read symbols on non-ELF binaries with libbfd, when
   supported, makes it possible for perf to report symbols and
   annotations for Windows applications running under Wine.

As you suggested, the libbfd code now tries to detect the binary format, 
  and early rejects if ELF is detected, so it then falls back to the 
libelf code path.
-- 
Rémi Bernon <rbernon@codeweavers.com>
