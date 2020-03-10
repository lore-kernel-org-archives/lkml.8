Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03624C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F0E24677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1sNOSrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCJOE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:04:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37901 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:04:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id e20so9713311qto.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1WCNCVf2+XZpjIVMYmw51M4OJB18oHp1Uyqi9aMBWjI=;
        b=s1sNOSrEyKKGrAmy38vHme14J0t4XP2fZZccJC5OU6ssHdkYVl7JdlEzseMlVrWnIS
         VNai9e4bAOMgrr3EgmGRfNblzxg7iiw9sooO4fQcT0P0O0G7qnIpYm2Up/OxjnUESVJ0
         NlI9lizxVBX3p8KHUfBp7IEKZd2aMIM1cAMd39lpc3RiZL/2LZXePfsYGe41R9RWwtWx
         tD1znl1H5C8+0QC1AUvLP+7Hi5Gae9/TPdtB5glUrgbitNl7Xy2wNuAr78r7TkmsQIq4
         A6WQmXk1Et5RDj7l1PRyc4bgfIOebUcJ/U8JkwmjIj98DzbxuhZn01Ws2fWslwGleTsF
         zTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1WCNCVf2+XZpjIVMYmw51M4OJB18oHp1Uyqi9aMBWjI=;
        b=sb6eppbJieYiHTw/6BW1RHIr9QnKktMJ8r1z8RAZ9GxsZRifIrq0TsM58Ug7Ino3+j
         LXyH71ZArYn6Hk83WeufFeSo9eV+G13aDkDyZqlvtW8CN2G4BmSeh2MJFjopc3HDxjCR
         W8ik9WpzT/VpvATvqX6KGe0yaWtmLaJ/LcuuB5/4HXd4Xs0TAVAxnjeYOFJCX5EU1a/w
         6XIl2zK+dKXDMyDJS7WAch0YSDr27Z5GtA/j/Wb+IezUv8SERcnk3MxEPLw1GIRZ7xun
         rD5lQao622RImM5kr8nWNm70+oXf1wuxpOePnJkP7PpUrPfXZ1G0bfwAzo25iIhe51m5
         hiyQ==
X-Gm-Message-State: ANhLgQ1tD1s+hnxEc2dY7uxwv2eZfIxG0UBKhBBBhmXAlUC+ler6PedX
        WvmFtAOtxOE2PTCsM/hrfWM=
X-Google-Smtp-Source: ADFU+vvOcZtAacPeUXd5aFw1GyEq4d/N9XloxPrqrj5PGhdYyO4zE9Enkl6gPaLjZ21nHs15/VxMsA==
X-Received: by 2002:ac8:70c3:: with SMTP id g3mr17431713qtp.353.1583849066674;
        Tue, 10 Mar 2020 07:04:26 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t4sm23977990qkm.82.2020.03.10.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:04:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68AC240009; Tue, 10 Mar 2020 11:04:21 -0300 (-03)
Date:   Tue, 10 Mar 2020 11:04:21 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V2 1/9] perf pmu: Add support for PMU capabilities
Message-ID: <20200310140421.GD15931@kernel.org>
References: <20200309174639.4594-1-kan.liang@linux.intel.com>
 <20200309174639.4594-2-kan.liang@linux.intel.com>
 <20200310130644.GC15931@kernel.org>
 <00ebb51d-0282-8181-7285-c60aec27566c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ebb51d-0282-8181-7285-c60aec27566c@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 10, 2020 at 09:53:24AM -0400, Liang, Kan escreveu:
> On 3/10/2020 9:06 AM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Mar 09, 2020 at 10:46:31AM -0700, kan.liang@linux.intel.com escreveu:
> > > +static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
> > > +{
> > > +	struct perf_pmu_caps *caps;
> > > +
> > > +	caps = zalloc(sizeof(*caps));
> > > +	if (!caps)
> > > +		return -ENOMEM;

> > So here you check if zalloc fails and returns a proper error

> > > +	caps->name = strdup(name);
> > > +	caps->value = strndup(value, strlen(value) - 1);

> > But then you don't check strdup()?
 
> Right, I should check strdup(), otherwise the capability information may be
> incomplete. I will fix it in V3.

Thanks, overall just consider making the patches smaller if possible,
with prep patches paving the way for more complex changes so that
reviewing becomes easier, for instance:

  perf machine: Refine the function for LBR call stack reconstruction

Seems to do too many things at once. It was unfortunate, for instance,
that the pre-existing code had that 

resolve_lbr_callchain_sample()
{
	/* LBR only affects the user callchain */
	if (i != chain_nr) {
		body of the function, long
		....
		return err;
	}

	return 0;
}

One of the things you did in this patch was to the more sensible:

	/* LBR only affects the user callchain */
	if (i == chain_nr)
		return 0;

	body of the function
	...
	return err;

So if you had a prep patch at this point just removing that silly
indent, then we would see that that is just removing the indent, the
next patch wouldn't have that check for user callchains, would be
smaller, I think that would help reduce the patch sizes.

Then if you just moved to a separate function the (callchain_param.order
== ORDER_CALLEE) part, the patch would again be smaller, etc.

This helps reviewing and usually helps us later, with bisection, when
some bug is introduced,

Regards,

- Arnaldo

> Thanks,
> Kan
> 
> > 
> > > +	list_add_tail(&caps->list, list);
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Reading/parsing the given pmu capabilities, which should be located at:
> > > + * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
> > > + * Return the number of capabilities
> > > + */
> > > +int perf_pmu__caps_parse(struct perf_pmu *pmu)
> > > +{
> > > +	struct stat st;
> > > +	char caps_path[PATH_MAX];
> > > +	const char *sysfs = sysfs__mountpoint();
> > > +	DIR *caps_dir;
> > > +	struct dirent *evt_ent;
> > > +	int nr_caps = 0;
> > > +
> > > +	if (!sysfs)
> > > +		return -1;
> > > +
> > > +	snprintf(caps_path, PATH_MAX,
> > > +		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
> > > +
> > > +	if (stat(caps_path, &st) < 0)
> > > +		return 0;	/* no error if caps does not exist */
> > > +
> > > +	caps_dir = opendir(caps_path);
> > > +	if (!caps_dir)
> > > +		return -EINVAL;
> > > +
> > > +	while ((evt_ent = readdir(caps_dir)) != NULL) {
> > > +		char path[PATH_MAX + NAME_MAX + 1];
> > > +		char *name = evt_ent->d_name;
> > > +		char value[128];
> > > +		FILE *file;
> > > +
> > > +		if (!strcmp(name, ".") || !strcmp(name, ".."))
> > > +			continue;
> > > +
> > > +		snprintf(path, sizeof(path), "%s/%s", caps_path, name);
> > > +
> > > +		file = fopen(path, "r");
> > > +		if (!file)
> > > +			break;
> > > +
> > > +		if (!fgets(value, sizeof(value), file) ||
> > > +		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
> > > +			fclose(file);
> > > +			break;
> > > +		}
> > > +
> > > +		nr_caps++;
> > > +		fclose(file);
> > > +	}
> > > +
> > > +	closedir(caps_dir);
> > > +
> > > +	return nr_caps;
> > > +}
> > > +
> > > +struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
> > > +					  struct perf_pmu_caps *caps)
> > > +{
> > > +	if (!pmu)
> > > +		return NULL;
> > > +
> > > +	if (!caps)
> > > +		caps = list_prepare_entry(caps, &pmu->caps, list);
> > > +
> > > +	list_for_each_entry_continue(caps, &pmu->caps, list)
> > > +		return caps;
> > > +
> > > +	return NULL;
> > > +}
> > > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > > index 6737e3d5d568..a228e27ae462 100644
> > > --- a/tools/perf/util/pmu.h
> > > +++ b/tools/perf/util/pmu.h
> > > @@ -21,6 +21,12 @@ enum {
> > >   struct perf_event_attr;
> > > +struct perf_pmu_caps {
> > > +	char *name;
> > > +	char *value;
> > > +	struct list_head list;
> > > +};
> > > +
> > >   struct perf_pmu {
> > >   	char *name;
> > >   	__u32 type;
> > > @@ -32,6 +38,7 @@ struct perf_pmu {
> > >   	struct perf_cpu_map *cpus;
> > >   	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
> > >   	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
> > > +	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
> > >   	struct list_head list;    /* ELEM */
> > >   };
> > > @@ -102,4 +109,9 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
> > >   int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
> > > +int perf_pmu__caps_parse(struct perf_pmu *pmu);
> > > +
> > > +struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
> > > +					  struct perf_pmu_caps *caps);
> > > +
> > >   #endif /* __PMU_H */
> > > -- 
> > > 2.17.1
> > > 
> > 

-- 

- Arnaldo
