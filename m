Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85319C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A9420773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbgFYKjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:39:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:55892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403816AbgFYKjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:39:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 161D6AD39;
        Thu, 25 Jun 2020 10:39:35 +0000 (UTC)
Date:   Thu, 25 Jun 2020 12:39:34 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Matt Helsley <mhelsley@vmware.com>
cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v5 03/51] objtool: Make recordmcount into mcount
 subcmd
In-Reply-To: <a76e7cd72dfd77ea8124771c4c6cdbddae3cdb65.1592510545.git.mhelsley@vmware.com>
Message-ID: <alpine.LSU.2.21.2006251230280.20731@pobox.suse.cz>
References: <cover.1592510545.git.mhelsley@vmware.com> <a76e7cd72dfd77ea8124771c4c6cdbddae3cdb65.1592510545.git.mhelsley@vmware.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020, Matt Helsley wrote:

> Rather than a standalone executable merge recordmcount as a sub command
> of objtool. This is a small step towards cleaning up recordmcount and
> eventually sharing  ELF code with objtool.
> 
> For the initial step all that's required is a bit of Makefile changes
> and invoking the former main() function from recordmcount.c because the
> subcommand code uses similar function arguments as main when dispatching.
> 
> objtool ignores some object files that tracing does not, specifically
> those with OBJECT_FILES_NON_STANDARD Makefile variables. For this reason
> we keep the recordmcount_dep separate from the objtool_dep. When using
> objtool mcount we can also, like the other objtool invocations, just
> depend on the binary rather than the source the binary is built from.
> 
> Subsequent patches will gradually convert recordmcount to use
> more and more of libelf/objtool's ELF accessor code. This will both
> clean up recordmcount to be more easily readable and remove
> recordmcount's crude accessor wrapping code.

I'll try to leave only relevant parts for a question below...

>  sub_cmd_record_mcount =					\
>  	if [ $(@) != "scripts/mod/empty.o" ]; then	\
> -		$(objtree)/tools/objtool/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
> +		$(objtree)/tools/objtool/objtool mcount record $(RECORDMCOUNT_FLAGS) "$(@)";	\
>  	fi;

> +int cmd_mcount(int argc, const char **argv)
> +{
> +	argc--; argv++;
> +	if (argc <= 0)
> +		usage_with_options(mcount_usage, mcount_options);
> +
> +	if (!strncmp(argv[0], "record", 6)) {
> +		argc = parse_options(argc, argv,
> +				     mcount_options, mcount_usage, 0);
> +		if (argc < 1)
> +			usage_with_options(mcount_usage, mcount_options);
> +
> +		return record_mcount(argc, argv);
> +	}
> +
> +	usage_with_options(mcount_usage, mcount_options);
> +
> +	return 0;
> +}

> -int main(int argc, char *argv[])
> +int record_mcount(int argc, const char **argv)
>  {
>  	const char ftrace[] = "/ftrace.o";
>  	int ftrace_size = sizeof(ftrace) - 1;
>  	int n_error = 0;  /* gcc-4.3.0 false positive complaint */
> -	int c;
>  	int i;
>  
> -	while ((c = getopt(argc, argv, "w")) >= 0) {
> -		switch (c) {
> -		case 'w':
> -			warn_on_notrace_sect = 1;
> -			break;
> -		default:
> -			fprintf(stderr, "usage: recordmcount [-w] file.o...\n");
> -			return 0;
> -		}
> -	}
> -
> -	if ((argc - optind) < 1) {
> -		fprintf(stderr, "usage: recordmcount [-w] file.o...\n");
> -		return 0;
> -	}
> -
>  	/* Process each file in turn, allowing deep failure. */
> -	for (i = optind; i < argc; i++) {
> -		char *file = argv[i];
> +	for (i = 0; i < argc; i++) {
> +		const char *file = argv[i];
>  		int len;

Do you expect that mcount subcmd would be called on more than one object 
file at a time? I don't see a reason for that with all the Makefile 
changes, but I may be missing something (Kbuild is a maze for me).

Because if not, I think it would be nice to make record_mcount() more 
similar to what we have for check(). After Julien's changes 
(20200608071203.4055-1-jthierry@redhat.com) at least. So that 
record_mcount() could accept struct objtool_file and work directly on 
that.

It would also impact several other patches in the series. For example, 
is there a need for a private 'struct elf *lf' in mcount.c?

Thanks
Miroslav
