Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC0C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094862083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598870618;
	bh=ckmfrTuA0VVG3gyTobwk6IyCkzl24Uc/8XqDWhN2ROU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FMsGDT0OQIvTlXWlgeqwT3yIn3KgrY50hxxQYyv6r6uFQmj6svbTqgf6Ui1MzQy7l
	 uDUm5A24CZUspdljgX+jHZzMYF/SeiXYmwKpiaftbjiEqIWgWgzXulpCQQhM2m4Hl1
	 3avOOrm1ZLQCYXN3RU9iuYx22AWLJHuZ6CQ7hNgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaKng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:43:36 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:38537 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:43:30 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 07VAh7cV016362
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:43:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 07VAh7cV016362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598870588;
        bh=d0FGzK1CH6ha2gWPD52vSKMZl72GbIXE80oYRByWCrI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fWBe4QamWY+lDo2u3wYtnnQE6ijukL/cMS7ArOtH23p5lilg5Hn+rcXM8I143l7wG
         mzqa2UfbM8Y1nVgWXqf9xr8qn3fov9xo5hQCszyMA5JI/Mps+vX+Lnf5nSdHFUrsF0
         yqKS0+iLrlROB078gE1Vxcf4mDBCKcJoOsdKrk/2/ElxRelAF1zG3v34xRIYQsoZGT
         VFHz4BVWnGPyreTLM88GGo8FahsRc0bB/Nvbz+3TZqvQGwFfDNTJZV6lZgpEVgyUKn
         woraTwFeqrCcPylmQSLez5g7eFa/faoq1/sWNv+4+Pm9wbwZ4EBk/Ez7s01wE/C2W3
         CfisPYpJQbt4Q==
X-Nifty-SrcIP: [209.85.214.172]
Received: by mail-pl1-f172.google.com with SMTP id h2so2848015plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 03:43:08 -0700 (PDT)
X-Gm-Message-State: AOAM5325sl50hyMedK3X1/INRWAjY/DFabelNKgDnUVdDN8NJPIY+Ynh
        qQI1oYQFai8vUFnEGQf7P+E7sZVnd7yiz3lIAsE=
X-Google-Smtp-Source: ABdhPJyud9RoE49gsQXVGc0nR/FApSQ0ZjZHc70WN9dVrsVqQsSefPpuQxcOPWDsZ+pHyXr65lBbe+Oo3wdT1un5hv8=
X-Received: by 2002:a17:90a:6f01:: with SMTP id d1mr793916pjk.198.1598870587288;
 Mon, 31 Aug 2020 03:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200812141557.GQ14398@arm.com> <20200812160017.GA30302@linux-8ccs>
 <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net> <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs> <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck> <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
 <20200821123036.GA21158@willie-the-truck> <20200831094651.GA16385@linux-8ccs>
In-Reply-To: <20200831094651.GA16385@linux-8ccs>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 31 Aug 2020 19:42:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARc1vjAV5ib1D0LaQA+rNGcE7YwGnp-MrshGD34_7V4WQ@mail.gmail.com>
Message-ID: <CAK7LNARc1vjAV5ib1D0LaQA+rNGcE7YwGnp-MrshGD34_7V4WQ@mail.gmail.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Content-Type: multipart/mixed; boundary="00000000000065d93205ae2a113e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000065d93205ae2a113e
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 31, 2020 at 6:47 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Will Deacon [21/08/20 13:30 +0100]:
> [snipped]
> >> > > > So module_enforce_rwx_sections() is already called after
> >> > > > module_frob_arch_sections() - which really baffled me at first, since
> >> > > > sh_type and sh_flags should have been set already in
> >> > > > module_frob_arch_sections().
> >> > > >
> >> > > > I added some debug prints to see which section the module code was
> >> > > > tripping on, and it was .text.ftrace_trampoline. See this snippet from
> >> > > > arm64's module_frob_arch_sections():
> >> > > >
> >> > > >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> >> > > >                          !strcmp(secstrings + sechdrs[i].sh_name,
> >> > > >                                  ".text.ftrace_trampoline"))
> >> > > >                         tramp = sechdrs + i;
> >> > > >
> >> > > > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
> >> > > > is never set here and the if (tramp) check at the end of the function
> >> > > > fails, so its section flags are never set, so they remain WAX and fail
> >> > > > the rwx check.
> >> > >
> >> > > Right. Our module.lds does not go through the preprocessor, so we
> >> > > cannot add the #ifdef check there currently. So we should either drop
> >> > > the IS_ENABLED() check here, or simply rename the section, dropping
> >> > > the .text prefix (which doesn't seem to have any significance outside
> >> > > this context)
> >> > >
> >> > > I'll leave it to Will to make the final call here.
> >> >
> >> > Why don't we just preprocess the linker script, like we do for the main
> >> > kernel?
> >> >
> >>
> >> That should work as well, I just haven't checked how straight-forward
> >> it is to change that.
> >
> >Ok, if it's _not_ straightforward, then let's just drop the IS_ENABLED()
> >altogether.
>
> Unfortunately I've been getting more reports about this issue, so let's just
> get the aforementioned workaround merged first. Does the following look OK?
>
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 0ce3a28e3347..2e224435c024 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -305,8 +305,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                         mod->arch.core.plt_shndx = i;
>                 else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
>                         mod->arch.init.plt_shndx = i;
> -               else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> -                        !strcmp(secstrings + sechdrs[i].sh_name,
> +               else if (!strcmp(secstrings + sechdrs[i].sh_name,
>                                  ".text.ftrace_trampoline"))
>                         tramp = sechdrs + i;
>                 else if (sechdrs[i].sh_type == SHT_SYMTAB)
>
> If so I'll turn it into a formal patch and we can get that merged in the next -rc.
>
> Thanks,
>
> Jessica



Sorry for the delay.

Please try the attached patch.


-- 
Best Regards
Masahiro Yamada

--00000000000065d93205ae2a113e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-kbuild-preprocess-module-linker-script.patch"
Content-Disposition: attachment; 
	filename="0001-kbuild-preprocess-module-linker-script.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_keie88910>
X-Attachment-Id: f_keie88910

RnJvbSA3MmIxMzIzM2U4NDNmNDdjNjk1OGNmMDY0NTY1M2RjNGE3Mjc1MTVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBGcmksIDI4IEF1ZyAyMDIwIDE2OjM3OjMzICswOTAwClN1YmplY3Q6IFtQQVRDSF0g
a2J1aWxkOiBwcmVwcm9jZXNzIG1vZHVsZSBsaW5rZXIgc2NyaXB0CgpUaGVyZSB3YXMgYSByZXF1
ZXN0IHRvIHByZXByb2Nlc3MgdGhlIG1vZHVsZSBsaW5rZXIgc2NyaXB0IGxpa2Ugd2UgZG8KZm9y
IHRoZSB2bWxpbnV4IG9uZSAoaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvOC8yMS81MTIpLgoK
VGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB2bWxpbnV4LmxkcyBhbmQgbW9kdWxlLmxkcyBpcyB0aGF0
IHRoZSBsYXR0ZXIKaXMgbmVlZGVkIGZvciBleHRlcm5hbCBtb2R1bGUgYnVpbGRzLCB0aHVzIG11
c3QgYmUgY2xlYW5lZCB1cCBieQonbWFrZSBtcnByb3BlcicgaW5zdGVhZCBvZiAnbWFrZSBjbGVh
bicgKGFsc28sIGl0IG11c3QgYmUgY3JlYXRlZCBieQonbWFrZSBtb2R1bGVzX3ByZXBhcmUnKS4K
CldlIGNhbm5vdCBwdXQgaXQgaW4gYXJjaC8qL2tlcm5lbC8gYmVjYXVzZSAnbWFrZSBjbGVhbicg
ZGVzY25lZHMgaW50bwppdC4KCnNjcmlwdHMvbW9kdWxlLmxkcyBpcyBhIGdvb2QgcGxhY2UgYmVj
YXVzZSAnbWFrZSBjbGVhbicga2VlcHMgYWxsIHRoZQpidWlsZCBhcnRpZmFjdHMgdW5kZXIgc2Ny
aXB0cy8uCgpZb3UgY2FuIGFkZCBhcmNoLXNwZWNpZmljIHNlY3Rpb25zIGluIDxhc20vbW9kdWxl
Lmxkcy5oPiwgd2hpY2ggaXMKaW5jbHVkZWQgZnJvbSBzY3JpcHRzL21vZHVsZS5sZHMuUy4KClNp
Z25lZC1vZmYtYnk6IE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhpcm95QGtlcm5lbC5vcmc+Ci0tLQog
TWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDEgLQogYXJjaC9hcm0vTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDQgLS0tLQogLi4uL3trZXJuZWwvbW9kdWxlLmxkcyA9PiBpbmNsdWRlL2FzbS9tb2R1
bGUubGRzLmh9ICAgIHwgIDIgKysKIGFyY2gvYXJtNjQvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICA0IC0tLS0KIC4uLi97a2VybmVsL21vZHVsZS5sZHMgPT4g
aW5jbHVkZS9hc20vbW9kdWxlLmxkcy5ofSAgICB8ICAyICsrCiBhcmNoL2lhNjQvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSAtCiBhcmNoL2lhNjQve21v
ZHVsZS5sZHMgPT4gaW5jbHVkZS9hc20vbW9kdWxlLmxkcy5ofSAgICAgfCAgMAogYXJjaC9tNjhr
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgLQogLi4u
L3trZXJuZWwvbW9kdWxlLmxkcyA9PiBpbmNsdWRlL2FzbS9tb2R1bGUubGRzLmh9ICAgIHwgIDAK
IGFyY2gvcG93ZXJwYy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAxIC0KIC4uLi97a2VybmVsL21vZHVsZS5sZHMgPT4gaW5jbHVkZS9hc20vbW9kdWxlLmxkcy5o
fSAgICB8ICAwCiBhcmNoL3Jpc2N2L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMyAtLS0KIC4uLi97a2VybmVsL21vZHVsZS5sZHMgPT4gaW5jbHVkZS9hc20v
bW9kdWxlLmxkcy5ofSAgICB8ICAzICsrLQogYXJjaC91bS9pbmNsdWRlL2FzbS9LYnVpbGQgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogaW5jbHVkZS9hc20tZ2VuZXJpYy9LYnVp
bGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogaW5jbHVkZS9hc20tZ2VuZXJp
Yy9tb2R1bGUubGRzLmggICAgICAgICAgICAgICAgICAgICAgIHwgMTAgKysrKysrKysrKwogc2Ny
aXB0cy8uZ2l0aWdub3JlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEg
Kwogc2NyaXB0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIgKysKIHNjcmlwdHMvTWFrZWZpbGUubW9kZmluYWwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICA1ICsrLS0tCiBzY3JpcHRzL3ttb2R1bGUtY29tbW9uLmxkcyA9PiBtb2R1bGUu
bGRzLlN9ICAgICAgICAgICAgfCAgMyArKysKIDIwIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlv
bnMoKyksIDE5IGRlbGV0aW9ucygtKQogcmVuYW1lIGFyY2gvYXJtL3trZXJuZWwvbW9kdWxlLmxk
cyA9PiBpbmNsdWRlL2FzbS9tb2R1bGUubGRzLmh9ICg3MiUpCiByZW5hbWUgYXJjaC9hcm02NC97
a2VybmVsL21vZHVsZS5sZHMgPT4gaW5jbHVkZS9hc20vbW9kdWxlLmxkcy5ofSAoNzYlKQogcmVu
YW1lIGFyY2gvaWE2NC97bW9kdWxlLmxkcyA9PiBpbmNsdWRlL2FzbS9tb2R1bGUubGRzLmh9ICgx
MDAlKQogcmVuYW1lIGFyY2gvbTY4ay97a2VybmVsL21vZHVsZS5sZHMgPT4gaW5jbHVkZS9hc20v
bW9kdWxlLmxkcy5ofSAoMTAwJSkKIHJlbmFtZSBhcmNoL3Bvd2VycGMve2tlcm5lbC9tb2R1bGUu
bGRzID0+IGluY2x1ZGUvYXNtL21vZHVsZS5sZHMuaH0gKDEwMCUpCiByZW5hbWUgYXJjaC9yaXNj
di97a2VybmVsL21vZHVsZS5sZHMgPT4gaW5jbHVkZS9hc20vbW9kdWxlLmxkcy5ofSAoODQlKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvYXNtLWdlbmVyaWMvbW9kdWxlLmxkcy5oCiByZW5h
bWUgc2NyaXB0cy97bW9kdWxlLWNvbW1vbi5sZHMgPT4gbW9kdWxlLmxkcy5TfSAoOTMlKQoKZGlm
ZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggOWNhYzZmZGUzNDc5Li4zZDliNTZj
NmI0N2UgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC01MDYsNyArNTA2
LDYgQEAgS0JVSUxEX0NGTEFHU19LRVJORUwgOj0KIEtCVUlMRF9BRkxBR1NfTU9EVUxFICA6PSAt
RE1PRFVMRQogS0JVSUxEX0NGTEFHU19NT0RVTEUgIDo9IC1ETU9EVUxFCiBLQlVJTERfTERGTEFH
U19NT0RVTEUgOj0KLWV4cG9ydCBLQlVJTERfTERTX01PRFVMRSA6PSAkKHNyY3RyZWUpL3Njcmlw
dHMvbW9kdWxlLWNvbW1vbi5sZHMKIEtCVUlMRF9MREZMQUdTIDo9CiBDTEFOR19GTEFHUyA6PQog
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9NYWtlZmlsZSBiL2FyY2gvYXJtL01ha2VmaWxlCmluZGV4
IDRlODc3MzU0NTE1Zi4uYTBjYjE1ZGU5Njc3IDEwMDY0NAotLS0gYS9hcmNoL2FybS9NYWtlZmls
ZQorKysgYi9hcmNoL2FybS9NYWtlZmlsZQpAQCAtMTYsMTAgKzE2LDYgQEAgTERGTEFHU192bWxp
bnV4CSs9IC0tYmU4CiBLQlVJTERfTERGTEFHU19NT0RVTEUJKz0gLS1iZTgKIGVuZGlmCiAKLWlm
ZXEgKCQoQ09ORklHX0FSTV9NT0RVTEVfUExUUykseSkKLUtCVUlMRF9MRFNfTU9EVUxFCSs9ICQo
c3JjdHJlZSkvYXJjaC9hcm0va2VybmVsL21vZHVsZS5sZHMKLWVuZGlmCi0KIEdaRkxBR1MJCTo9
LTkKICNLQlVJTERfQ0ZMQUdTCSs9LXBpcGUKIApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0va2VybmVs
L21vZHVsZS5sZHMgYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9tb2R1bGUubGRzLmgKc2ltaWxhcml0
eSBpbmRleCA3MiUKcmVuYW1lIGZyb20gYXJjaC9hcm0va2VybmVsL21vZHVsZS5sZHMKcmVuYW1l
IHRvIGFyY2gvYXJtL2luY2x1ZGUvYXNtL21vZHVsZS5sZHMuaAppbmRleCA3OWNiNmFmNTY1ZTUu
LjBlN2NiNGUzMTRiNCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0va2VybmVsL21vZHVsZS5sZHMKKysr
IGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vbW9kdWxlLmxkcy5oCkBAIC0xLDUgKzEsNyBAQAogLyog
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8KKyNpZmRlZiBDT05GSUdfQVJNX01P
RFVMRV9QTFRTCiBTRUNUSU9OUyB7CiAJLnBsdCA6IHsgQllURSgwKSB9CiAJLmluaXQucGx0IDog
eyBCWVRFKDApIH0KIH0KKyNlbmRpZgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9NYWtlZmlsZSBi
L2FyY2gvYXJtNjQvTWFrZWZpbGUKaW5kZXggNTViYzg1NDZkOWM3Li4yMzI1NDdlYzA3ZDggMTAw
NjQ0Ci0tLSBhL2FyY2gvYXJtNjQvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm02NC9NYWtlZmlsZQpA
QCAtMTE1LDEwICsxMTUsNiBAQCBlbmRpZgogCiBDSEVDS0ZMQUdTCSs9IC1EX19hYXJjaDY0X18K
IAotaWZlcSAoJChDT05GSUdfQVJNNjRfTU9EVUxFX1BMVFMpLHkpCi1LQlVJTERfTERTX01PRFVM
RQkrPSAkKHNyY3RyZWUpL2FyY2gvYXJtNjQva2VybmVsL21vZHVsZS5sZHMKLWVuZGlmCi0KIGlm
ZXEgKCQoQ09ORklHX0RZTkFNSUNfRlRSQUNFX1dJVEhfUkVHUykseSkKICAgS0JVSUxEX0NQUEZM
QUdTICs9IC1EQ0NfVVNJTkdfUEFUQ0hBQkxFX0ZVTkNUSU9OX0VOVFJZCiAgIENDX0ZMQUdTX0ZU
UkFDRSA6PSAtZnBhdGNoYWJsZS1mdW5jdGlvbi1lbnRyeT0yCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2tlcm5lbC9tb2R1bGUubGRzIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tb2R1bGUubGRz
LmgKc2ltaWxhcml0eSBpbmRleCA3NiUKcmVuYW1lIGZyb20gYXJjaC9hcm02NC9rZXJuZWwvbW9k
dWxlLmxkcwpyZW5hbWUgdG8gYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tb2R1bGUubGRzLmgKaW5k
ZXggMjJlMzZhMjFjMTEzLi42OTFmMTVhZjc4OGUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva2Vy
bmVsL21vZHVsZS5sZHMKKysrIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tb2R1bGUubGRzLmgK
QEAgLTEsNSArMSw3IEBACisjaWZkZWYgQ09ORklHX0FSTTY0X01PRFVMRV9QTFRTCiBTRUNUSU9O
UyB7CiAJLnBsdCAoTk9MT0FEKSA6IHsgQllURSgwKSB9CiAJLmluaXQucGx0IChOT0xPQUQpIDog
eyBCWVRFKDApIH0KIAkudGV4dC5mdHJhY2VfdHJhbXBvbGluZSAoTk9MT0FEKSA6IHsgQllURSgw
KSB9CiB9CisjZW5kaWYKZGlmZiAtLWdpdCBhL2FyY2gvaWE2NC9NYWtlZmlsZSBiL2FyY2gvaWE2
NC9NYWtlZmlsZQppbmRleCAyODc2YTdkZjFiMGEuLjcwM2IxYzRmNmQxMiAxMDA2NDQKLS0tIGEv
YXJjaC9pYTY0L01ha2VmaWxlCisrKyBiL2FyY2gvaWE2NC9NYWtlZmlsZQpAQCAtMjAsNyArMjAs
NiBAQCBDSEVDS0ZMQUdTCSs9IC1EX19pYTY0PTEgLURfX2lhNjRfXz0xIC1EX0xQNjQgLURfX0xQ
NjRfXwogCiBPQkpDT1BZRkxBR1MJOj0gLS1zdHJpcC1hbGwKIExERkxBR1Nfdm1saW51eAk6PSAt
c3RhdGljCi1LQlVJTERfTERTX01PRFVMRSArPSAkKHNyY3RyZWUpL2FyY2gvaWE2NC9tb2R1bGUu
bGRzCiBLQlVJTERfQUZMQUdTX0tFUk5FTCA6PSAtbWNvbnN0YW50LWdwCiBFWFRSQQkJOj0KIApk
aWZmIC0tZ2l0IGEvYXJjaC9pYTY0L21vZHVsZS5sZHMgYi9hcmNoL2lhNjQvaW5jbHVkZS9hc20v
bW9kdWxlLmxkcy5oCnNpbWlsYXJpdHkgaW5kZXggMTAwJQpyZW5hbWUgZnJvbSBhcmNoL2lhNjQv
bW9kdWxlLmxkcwpyZW5hbWUgdG8gYXJjaC9pYTY0L2luY2x1ZGUvYXNtL21vZHVsZS5sZHMuaApk
aWZmIC0tZ2l0IGEvYXJjaC9tNjhrL01ha2VmaWxlIGIvYXJjaC9tNjhrL01ha2VmaWxlCmluZGV4
IDQ0MzhmZmI0YmJlMS4uZWExNGYyMDQ2ZmI0IDEwMDY0NAotLS0gYS9hcmNoL202OGsvTWFrZWZp
bGUKKysrIGIvYXJjaC9tNjhrL01ha2VmaWxlCkBAIC03NSw3ICs3NSw2IEBAIEtCVUlMRF9DUFBG
TEFHUyArPSAtRF9fdUNsaW51eF9fCiBlbmRpZgogCiBLQlVJTERfTERGTEFHUyA6PSAtbSBtNjhr
ZWxmCi1LQlVJTERfTERTX01PRFVMRSArPSAkKHNyY3RyZWUpL2FyY2gvbTY4ay9rZXJuZWwvbW9k
dWxlLmxkcwogCiBpZmRlZiBDT05GSUdfU1VOMwogTERGTEFHU192bWxpbnV4ID0gLU4KZGlmZiAt
LWdpdCBhL2FyY2gvbTY4ay9rZXJuZWwvbW9kdWxlLmxkcyBiL2FyY2gvbTY4ay9pbmNsdWRlL2Fz
bS9tb2R1bGUubGRzLmgKc2ltaWxhcml0eSBpbmRleCAxMDAlCnJlbmFtZSBmcm9tIGFyY2gvbTY4
ay9rZXJuZWwvbW9kdWxlLmxkcwpyZW5hbWUgdG8gYXJjaC9tNjhrL2luY2x1ZGUvYXNtL21vZHVs
ZS5sZHMuaApkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL01ha2VmaWxlIGIvYXJjaC9wb3dlcnBj
L01ha2VmaWxlCmluZGV4IDNlOGRhOWNmMmViOS4uODkzNTY1OGZjZDA2IDEwMDY0NAotLS0gYS9h
cmNoL3Bvd2VycGMvTWFrZWZpbGUKKysrIGIvYXJjaC9wb3dlcnBjL01ha2VmaWxlCkBAIC02NSw3
ICs2NSw2IEBAIFVUU19NQUNISU5FIDo9ICQoc3Vic3QgJChzcGFjZSksLCQobWFjaGluZS15KSkK
IGlmZGVmIENPTkZJR19QUEMzMgogS0JVSUxEX0xERkxBR1NfTU9EVUxFICs9IGFyY2gvcG93ZXJw
Yy9saWIvY3J0c2F2cmVzLm8KIGVsc2UKLUtCVUlMRF9MRFNfTU9EVUxFICs9ICQoc3JjdHJlZSkv
YXJjaC9wb3dlcnBjL2tlcm5lbC9tb2R1bGUubGRzCiBpZmVxICgkKGNhbGwgbGQtaWZ2ZXJzaW9u
LCAtZ2UsIDIyNTAwMDAwMCwgeSkseSkKICMgSGF2ZSB0aGUgbGlua2VyIHByb3ZpZGUgc2ZwciBp
ZiBwb3NzaWJsZS4KICMgVGhlcmUgaXMgYSBjb3JyZXNwb25kaW5nIHRlc3QgaW4gYXJjaC9wb3dl
cnBjL2xpYi9NYWtlZmlsZQpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9tb2R1bGUu
bGRzIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL21vZHVsZS5sZHMuaApzaW1pbGFyaXR5IGlu
ZGV4IDEwMCUKcmVuYW1lIGZyb20gYXJjaC9wb3dlcnBjL2tlcm5lbC9tb2R1bGUubGRzCnJlbmFt
ZSB0byBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbW9kdWxlLmxkcy5oCmRpZmYgLS1naXQgYS9h
cmNoL3Jpc2N2L01ha2VmaWxlIGIvYXJjaC9yaXNjdi9NYWtlZmlsZQppbmRleCBmYjZlMzdkYjgz
NmQuLjhlZGFhOGJkODZkNiAxMDA2NDQKLS0tIGEvYXJjaC9yaXNjdi9NYWtlZmlsZQorKysgYi9h
cmNoL3Jpc2N2L01ha2VmaWxlCkBAIC01Myw5ICs1Myw2IEBAIGVuZGlmCiBpZmVxICgkKENPTkZJ
R19DTU9ERUxfTUVEQU5ZKSx5KQogCUtCVUlMRF9DRkxBR1MgKz0gLW1jbW9kZWw9bWVkYW55CiBl
bmRpZgotaWZlcSAoJChDT05GSUdfTU9EVUxFX1NFQ1RJT05TKSx5KQotCUtCVUlMRF9MRFNfTU9E
VUxFICs9ICQoc3JjdHJlZSkvYXJjaC9yaXNjdi9rZXJuZWwvbW9kdWxlLmxkcwotZW5kaWYKIGlm
ZXEgKCQoQ09ORklHX1BFUkZfRVZFTlRTKSx5KQogICAgICAgICBLQlVJTERfQ0ZMQUdTICs9IC1m
bm8tb21pdC1mcmFtZS1wb2ludGVyCiBlbmRpZgpkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJu
ZWwvbW9kdWxlLmxkcyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vbW9kdWxlLmxkcy5oCnNpbWls
YXJpdHkgaW5kZXggODQlCnJlbmFtZSBmcm9tIGFyY2gvcmlzY3Yva2VybmVsL21vZHVsZS5sZHMK
cmVuYW1lIHRvIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vbW9kdWxlLmxkcy5oCmluZGV4IDI5NWVj
ZmIzNDFhMi4uNDI1NGZmMmZmMDQ5IDEwMDY0NAotLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9tb2R1
bGUubGRzCisrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vbW9kdWxlLmxkcy5oCkBAIC0xLDgg
KzEsOSBAQAogLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8KIC8qIENvcHly
aWdodCAoQykgMjAxNyBBbmRlcyBUZWNobm9sb2d5IENvcnBvcmF0aW9uICovCi0KKyNpZmRlZiBD
T05GSUdfTU9EVUxFX1NFQ1RJT05TCiBTRUNUSU9OUyB7CiAJLnBsdCAoTk9MT0FEKSA6IHsgQllU
RSgwKSB9CiAJLmdvdCAoTk9MT0FEKSA6IHsgQllURSgwKSB9CiAJLmdvdC5wbHQgKE5PTE9BRCkg
OiB7IEJZVEUoMCkgfQogfQorI2VuZGlmCmRpZmYgLS1naXQgYS9hcmNoL3VtL2luY2x1ZGUvYXNt
L0tidWlsZCBiL2FyY2gvdW0vaW5jbHVkZS9hc20vS2J1aWxkCmluZGV4IDhkNDM1ZjhhNmRlYy4u
MWM2M2IyNjBlY2M0IDEwMDY0NAotLS0gYS9hcmNoL3VtL2luY2x1ZGUvYXNtL0tidWlsZAorKysg
Yi9hcmNoL3VtL2luY2x1ZGUvYXNtL0tidWlsZApAQCAtMTYsNiArMTYsNyBAQCBnZW5lcmljLXkg
Kz0ga2RlYnVnLmgKIGdlbmVyaWMteSArPSBtY3Nfc3BpbmxvY2suaAogZ2VuZXJpYy15ICs9IG1t
LWFyY2gtaG9va3MuaAogZ2VuZXJpYy15ICs9IG1taW93Yi5oCitnZW5lcmljLXkgKz0gbW9kdWxl
Lmxkcy5oCiBnZW5lcmljLXkgKz0gcGFyYW0uaAogZ2VuZXJpYy15ICs9IHBjaS5oCiBnZW5lcmlj
LXkgKz0gcGVyY3B1LmgKZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvS2J1aWxkIGIv
aW5jbHVkZS9hc20tZ2VuZXJpYy9LYnVpbGQKaW5kZXggNzRiMDYxMjYwMWRkLi43Y2Q0ZTYyN2Uw
MGUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvS2J1aWxkCisrKyBiL2luY2x1ZGUv
YXNtLWdlbmVyaWMvS2J1aWxkCkBAIC00MCw2ICs0MCw3IEBAIG1hbmRhdG9yeS15ICs9IG1taW93
Yi5oCiBtYW5kYXRvcnkteSArPSBtbXUuaAogbWFuZGF0b3J5LXkgKz0gbW11X2NvbnRleHQuaAog
bWFuZGF0b3J5LXkgKz0gbW9kdWxlLmgKK21hbmRhdG9yeS15ICs9IG1vZHVsZS5sZHMuaAogbWFu
ZGF0b3J5LXkgKz0gbXNpLmgKIG1hbmRhdG9yeS15ICs9IHBjaS5oCiBtYW5kYXRvcnkteSArPSBw
ZXJjcHUuaApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9tb2R1bGUubGRzLmggYi9p
bmNsdWRlL2FzbS1nZW5lcmljL21vZHVsZS5sZHMuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwMDAwMDAuLjg3ZTcwN2NjMDc0OQotLS0gL2Rldi9udWxsCisrKyBiL2luY2x1ZGUv
YXNtLWdlbmVyaWMvbW9kdWxlLmxkcy5oCkBAIC0wLDAgKzEsMTAgQEAKKy8qIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8KKyNpZm5kZWYgX19BU01fR0VORVJJQ19NT0RV
TEVfTERTX0gKKyNkZWZpbmUgX19BU01fR0VORVJJQ19NT0RVTEVfTERTX0gKKworLyoKKyAqIDxh
c20vbW9kdWxlLmxkcy5oPiBjYW4gc3BlY2lmeSBhcmNoLXNwZWNpZmljIHNlY3Rpb25zIGZvciBs
aW5raW5nIG1vZHVsZXMuCisgKiBFbXB0eSBmb3IgYXNtLWdlbmVyaWMgaGVhZGVyCisgKi8KKwor
I2VuZGlmIC8qIF9fQVNNX0dFTkVSSUNfTU9EVUxFX0xEU19IICovCmRpZmYgLS1naXQgYS9zY3Jp
cHRzLy5naXRpZ25vcmUgYi9zY3JpcHRzLy5naXRpZ25vcmUKaW5kZXggMGQxYzhlMjE3Y2Q3Li5h
NmMxMTMxNmM5NjkgMTAwNjQ0Ci0tLSBhL3NjcmlwdHMvLmdpdGlnbm9yZQorKysgYi9zY3JpcHRz
Ly5naXRpZ25vcmUKQEAgLTgsMyArOCw0IEBAIGFzbjFfY29tcGlsZXIKIGV4dHJhY3QtY2VydAog
c2lnbi1maWxlCiBpbnNlcnQtc3lzLWNlcnQKKy9tb2R1bGUubGRzCmRpZmYgLS1naXQgYS9zY3Jp
cHRzL01ha2VmaWxlIGIvc2NyaXB0cy9NYWtlZmlsZQppbmRleCBiYzAxOGU0YjczM2UuLmE1MDU4
YmZkZDBmNiAxMDA2NDQKLS0tIGEvc2NyaXB0cy9NYWtlZmlsZQorKysgYi9zY3JpcHRzL01ha2Vm
aWxlCkBAIC0yOSw2ICsyOSw4IEBAIGVuZGlmCiAjIFRoZSBmb2xsb3dpbmcgcHJvZ3JhbXMgYXJl
IG9ubHkgYnVpbHQgb24gZGVtYW5kCiBob3N0cHJvZ3MgKz0gdW5pZmRlZgogCithbHdheXMtJChD
T05GSUdfTU9EVUxFUykJKz0gbW9kdWxlLmxkcworCiBzdWJkaXItJChDT05GSUdfR0NDX1BMVUdJ
TlMpICs9IGdjYy1wbHVnaW5zCiBzdWJkaXItJChDT05GSUdfTU9EVkVSU0lPTlMpICs9IGdlbmtz
eW1zCiBzdWJkaXItJChDT05GSUdfU0VDVVJJVFlfU0VMSU5VWCkgKz0gc2VsaW51eApkaWZmIC0t
Z2l0IGEvc2NyaXB0cy9NYWtlZmlsZS5tb2RmaW5hbCBiL3NjcmlwdHMvTWFrZWZpbGUubW9kZmlu
YWwKaW5kZXggNDExYzFlNjAwZTdkLi5hZTAxYmFmOTZmNGUgMTAwNjQ0Ci0tLSBhL3NjcmlwdHMv
TWFrZWZpbGUubW9kZmluYWwKKysrIGIvc2NyaXB0cy9NYWtlZmlsZS5tb2RmaW5hbApAQCAtMzMs
MTEgKzMzLDEwIEBAIHF1aWV0X2NtZF9sZF9rb19vID0gTEQgW01dICAkQAogICAgICAgY21kX2xk
X2tvX28gPSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAogCSQoTEQpIC1yICQoS0JVSUxEX0xERkxBR1MpCQkJCQlcCiAJCSQoS0JVSUxEX0xERkxB
R1NfTU9EVUxFKSAkKExERkxBR1NfTU9EVUxFKQkJXAotCQkkKGFkZHByZWZpeCAtVCAsICQoS0JV
SUxEX0xEU19NT0RVTEUpKQkJCVwKLQkJLW8gJEAgJChmaWx0ZXIgJS5vLCAkXik7CQkJCVwKKwkJ
LVQgc2NyaXB0cy9tb2R1bGUubGRzIC1vICRAICQoZmlsdGVyICUubywgJF4pOwkJXAogCSQoaWYg
JChBUkNIX1BPU1RMSU5LKSwgJChNQUtFKSAtZiAkKEFSQ0hfUE9TVExJTkspICRALCB0cnVlKQog
Ci0kKG1vZHVsZXMpOiAlLmtvOiAlLm8gJS5tb2QubyAkKEtCVUlMRF9MRFNfTU9EVUxFKSBGT1JD
RQorJChtb2R1bGVzKTogJS5rbzogJS5vICUubW9kLm8gc2NyaXB0cy9tb2R1bGUubGRzIEZPUkNF
CiAJKyQoY2FsbCBpZl9jaGFuZ2VkLGxkX2tvX28pCiAKIHRhcmdldHMgKz0gJChtb2R1bGVzKSAk
KG1vZHVsZXM6LmtvPS5tb2QubykKZGlmZiAtLWdpdCBhL3NjcmlwdHMvbW9kdWxlLWNvbW1vbi5s
ZHMgYi9zY3JpcHRzL21vZHVsZS5sZHMuUwpzaW1pbGFyaXR5IGluZGV4IDkzJQpyZW5hbWUgZnJv
bSBzY3JpcHRzL21vZHVsZS1jb21tb24ubGRzCnJlbmFtZSB0byBzY3JpcHRzL21vZHVsZS5sZHMu
UwppbmRleCBkNjFiOWU4Njc4ZTguLjY5YjliNzFhNmE0NyAxMDA2NDQKLS0tIGEvc2NyaXB0cy9t
b2R1bGUtY29tbW9uLmxkcworKysgYi9zY3JpcHRzL21vZHVsZS5sZHMuUwpAQCAtMjQsMyArMjQs
NiBAQCBTRUNUSU9OUyB7CiAKIAlfX2p1bXBfdGFibGUJCTAgOiBBTElHTig4KSB7IEtFRVAoKihf
X2p1bXBfdGFibGUpKSB9CiB9CisKKy8qIGJyaW5nIGluIGFyY2gtc3BlY2lmaWMgc2VjdGlvbnMg
Ki8KKyNpbmNsdWRlIDxhc20vbW9kdWxlLmxkcy5oPgotLSAKMi4yNS4xCgo=
--00000000000065d93205ae2a113e--
