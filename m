Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079C6C2BA17
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E142074B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585966695;
	bh=njNMvkZSwli/XJkxlAL53ySvEgIh59jJQ3Da06ltvek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lDOjKAVcC6B7omm/ySmUIneFImF28GRyTfXCIlBYcUm7rw+JrMUbZrPVS6xw8CS3I
	 72VFTMI4+isqPClYYw0hJ0sUO5upQlyZskERICms8cmQ6m7gvju2BfzhfMExTI7DB/
	 B7ZLh5oNc6J+eWrN8uU97Q64++ubB0mD3Qs9viAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgDDCSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 22:18:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45200 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDDCSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 22:18:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so10674736wrw.12;
        Fri, 03 Apr 2020 19:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njNMvkZSwli/XJkxlAL53ySvEgIh59jJQ3Da06ltvek=;
        b=gv9D3JLkR70KFj803XPuYbGbgbQUTnF2FrnoTRCbbyCT1noB0z+FIf+evrwabohIRE
         Xs7DmBRIK5YH65XgsD/wfj8UOijueV0y8ldaSbEbVXMSFomtUjE7eMwH67LkQifUZ2O+
         HbFIhdzp/d05b5U0Z4MdwG2ALUoX2pHasMVACM3WZmjWl87i4in4XF6ehNiX/H5A44Yp
         QXeMbzwQre3qKxS1vFmV3tH5+nH1EMsJWTFFPkZ5RdxwNmBkvfWuKIY096LQ0UD82DUv
         Qwt9FX7rMCWNGjv+0hFq7ku6M2RmERk3YYwauJIeE125Wr9B7tWHWnQXeNKW2jcXvwY6
         /rLg==
X-Gm-Message-State: AGi0PuYXXSS1gplkz101/0uZWKZvBpSsWcphwzB8LqxcPm2IRusv8xWU
        7lHP2S3iL9x9gSFal2VkovtWFkmTi14gPY6vGx4=
X-Google-Smtp-Source: APiQypITt+t9SHGiW3VBj3kiVR4I11z137wBPJZ4Q7W9GsJPRGwRvzLCZ0lCixu8k2odpcKExmR8YBOh7LpnxfMyanc=
X-Received: by 2002:a5d:474b:: with SMTP id o11mr11926654wrs.391.1585966692198;
 Fri, 03 Apr 2020 19:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <f96f8f8a-e65c-3f36-dc85-fc3f5191e8c5@linux.intel.com> <a66d5648-2b8e-577e-e1f2-1d56c017ab5e@linux.intel.com>
In-Reply-To: <a66d5648-2b8e-577e-e1f2-1d56c017ab5e@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 4 Apr 2020 11:18:01 +0900
Message-ID: <CAM9d7cgRczLcyUi1y96a=87Hh3BhFgRUS8Kw=DBg4C0hVYj2HQ@mail.gmail.com>
Subject: Re: [PATCH v8 04/12] perf tool: extend Perf tool with CAP_PERFMON
 capability support
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, Jiri Olsa <jolsa@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 2, 2020 at 5:47 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Extend error messages to mention CAP_PERFMON capability as an option
> to substitute CAP_SYS_ADMIN capability for secure system performance
> monitoring and observability operations. Make perf_event_paranoid_check()
> and __cmd_ftrace() to be aware of CAP_PERFMON capability.
>
> CAP_PERFMON implements the principal of least privilege for performance
> monitoring and observability operations (POSIX IEEE 1003.1e 2.2.2.39
> principle of least privilege: A security design principle that states
> that a process or program be granted only those privileges (e.g.,
> capabilities) necessary to accomplish its legitimate function, and only
> for the time that such privileges are actually required)
>
> For backward compatibility reasons access to perf_events subsystem remains
> open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for
> secure perf_events monitoring is discouraged with respect to CAP_PERFMON
> capability.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> Reviewed-by: James Morris <jamorris@linux.microsoft.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung
